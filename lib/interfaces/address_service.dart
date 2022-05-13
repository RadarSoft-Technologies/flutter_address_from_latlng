import 'package:flutter_address_from_latlng/repository/address_repository.dart';
import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';
import 'package:flutter_address_from_latlng/utils/string_utils.dart';
import '../models/my_address.dart';

class AddressService implements AddressFromLatLngInterface {
  final AddressRepository repository;
  final StringUtils stringUtils;

  AddressService({
    required this.repository,
    required this.stringUtils,
  });

  /// This method filter the address list objects which are present in
  /// [MyAddress],s [Results] list and return a possible most optimized
  /// and most informative formatted address
  ///
  ///
  /// Gather addresses by analysing various criteria like [streetAddressList],
  /// [premiseAddressList], [subLocalityAddressList] and make a decision which
  /// address is more informative
  String _filterAndGetFormattedAddress({required MyAddress? myAddress}) {
    if (myAddress == null || myAddress.status != 'OK' || myAddress.results.isEmpty) {
      return '';
    }

    List<String> streetAddressList = [];
    List<String> premiseAddressList = [];
    List<String> subLocalityAddressList = [];
    for (Results result in myAddress.results) {
      /// street address
      if (result.types.contains('street_address')) {
        streetAddressList.add(result.formattedAddress ?? '');
      }

      /// premise address
      if (result.types.contains('premise')) {
        premiseAddressList.add(result.formattedAddress ?? '');
      }

      /// sublocality address
      if (result.types.contains('sublocality')) {
        subLocalityAddressList.add(result.formattedAddress ?? '');
      } else {
        for (var tps in result.types) {
          if (tps.contains('sublocality')) {
            subLocalityAddressList.add(result.formattedAddress ?? '');
          }
        }
      }
    }

    String premiseAddress = stringUtils.getMaxStringFromList(premiseAddressList);
    String streetAddress = stringUtils.getMaxStringFromList(streetAddressList);
    String subLocalityAddress = stringUtils.getMaxStringFromList(subLocalityAddressList);
    String firstAddress = myAddress.results[0].formattedAddress ?? '';

    String finalAddress =
        premiseAddress.length > streetAddress.length ? premiseAddress : streetAddress;
    finalAddress =
        finalAddress.length > subLocalityAddress.length ? finalAddress : subLocalityAddress;
    finalAddress = finalAddress.length > firstAddress.length ? finalAddress : firstAddress;

    //print('\n\npremise address      = $premiseAddress');
    //print('street address       = $streetAddress');
    //print('sub-locality address = $subLocalityAddress');
    //print('first address        = ${myAddress.results.first.formattedAddress}');

    return finalAddress;
  }

  @override
  Future<String> getFormattedAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    MyAddress? myAddress = await repository.getAddressFromCoordinate(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );

    return _filterAndGetFormattedAddress(myAddress: myAddress);
  }
}
