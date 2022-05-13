import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';

import '../models/my_address.dart';

class AddressService implements AddressFromLatLngInterface{

  /// This method makes a network call using[http] library and get an address list
  /// from google [geocoding] api and returns a list of [Results] in [MyAddress] model
  ///
  /// [latitude] the latitude of the place that we wand to get address
  /// [longitude] the longitude of the place that we want to get address
  /// [gApiKey] is the key to access Google Geo APIs
  Future<MyAddress?> _getAddressFromCoordinate({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    try {
      final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$gApiKey',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return MyAddress.fromJson(jsonDecode(response.body));
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  /// This method return a string with max length from [lst] list
  String _getMaxString(List<String> lst){
    String maxAddress = '';
    for(String v in lst){
      maxAddress = (maxAddress.length < v.length) ? v : maxAddress;
    }
    return maxAddress;
  }

  /// This method filter the address list objects which are present in
  /// [MyAddress],s [Results] list and return a possible most optimized
  /// and most informative formatted address
  ///
  ///
  /// Gather addresses by analysing various criteria like [streetAddressList],
  /// [premiseAddressList], [subLocalityAddressList] and make a decision which
  /// address is more informative
  String _filterAndGetFormattedAddress({required MyAddress? myAddress}){
    if(myAddress == null || myAddress.status != 'OK' || myAddress.results.isEmpty){
      return '';
    }

    List<String> streetAddressList = [];
    List<String> premiseAddressList = [];
    List<String> subLocalityAddressList = [];
    for(Results result in myAddress.results){
      /// street address
      if(result.types.contains('street_address')){
        streetAddressList.add(result.formattedAddress ?? '');
      }

      /// premise address
      if(result.types.contains('premise')){
        premiseAddressList.add(result.formattedAddress ?? '');
      }

      /// sublocality address
      if(result.types.contains('sublocality')){
        subLocalityAddressList.add(result.formattedAddress ?? '');
      }else{
        for(var tps in result.types){
          if(tps.contains('sublocality')){
            subLocalityAddressList.add(result.formattedAddress ?? '');
          }
        }
      }

    }

    String premiseAddress = _getMaxString(premiseAddressList);
    String streetAddress = _getMaxString(streetAddressList);
    String subLocalityAddress = _getMaxString(subLocalityAddressList);
    String firstAddress = myAddress.results[0].formattedAddress ?? '';

    String finalAddress = premiseAddress.length > streetAddress.length ? premiseAddress : streetAddress;
    finalAddress = finalAddress.length > subLocalityAddress.length ? finalAddress : subLocalityAddress;
    finalAddress = finalAddress.length > firstAddress.length ? finalAddress : firstAddress;

    print('\n\npremise address      = $premiseAddress');
    print('street address       = $streetAddress');
    print('sub-locality address = $subLocalityAddress');
    print('first address        = ${myAddress.results.first.formattedAddress}');

    return finalAddress;
  }

  @override
  Future<String> getMostPerfectAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
}) async {
    MyAddress? myAddress = await _getAddressFromCoordinate(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );

    return _filterAndGetFormattedAddress(myAddress: myAddress);
  }
}