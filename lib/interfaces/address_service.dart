import 'package:flutter_address_from_latlng/models/address_types.dart';
import 'package:flutter_address_from_latlng/repository/address_repository.dart';
import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';
import 'package:flutter_address_from_latlng/utils/string_utils.dart';
import '../models/address_response.dart';

class AddressService implements AddressFromLatLngInterface {
  final AddressRepository repository;
  final StringUtils stringUtils;

  AddressService({
    required this.repository,
    required this.stringUtils,
  });

  /// This method filter the address list objects which are present in
  /// [AddressResponse],s [Address] list and return a possible most optimized
  /// and most informative formatted address
  ///
  ///
  /// Gather addresses by analysing various criteria like [streetAddressList],
  /// [premiseAddressList], [subLocalityAddressList] and make a decision which
  /// address is more informative
  String _filterAndGetFormattedAddress({required AddressResponse? myAddress}) {
    if (myAddress == null || myAddress.status != 'OK' || myAddress.results.isEmpty) {
      return '';
    }

    List<String> streetAddressList = [];
    List<String> premiseAddressList = [];
    List<String> subLocalityAddressList = [];
    for (Address result in myAddress.results) {
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

  /// This method returns an address from given [addressList] if any address
  /// match with the given [addressType] if exist in [addressList]
  ///
  /// if address is not present in [addressList] then return null
  Future<Address?> _getAddressByType({
    required double latitude,
    required double longitude,
    required String gApiKey,
    required AddressType addressType,
  }) async {
    AddressResponse? myAddress = await repository.getAddressFromCoordinate(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );

    if (myAddress == null) return null;

    for (var v in myAddress.results) {
      if (v.types.contains(addressType.toString())) {
        return v;
      }
    }
    return null;
  }

  @override
  Future<String> getFormattedAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    AddressResponse? myAddress = await repository.getAddressFromCoordinate(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );

    return _filterAndGetFormattedAddress(myAddress: myAddress);
  }

  @override
  Future<Address?> getPremiseAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.premise,
    );
  }

  @override
  Future<Address?> getDirectionAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.route,
    );
  }

  @override
  Future<Address?> getStreetAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.street_address,
    );
  }

  @override
  Future<Address?> getAdministrativeAddress1({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.administrative_area_level_1,
    );
  }

  @override
  Future<Address?> getAdministrativeAddress2({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.administrative_area_level_2,
    );
  }

  @override
  Future<Address?> getAdministrativeAddress3({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.administrative_area_level_3,
    );
  }

  @override
  Future<Address?> getCountryAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.country,
    );
  }

  @override
  Future<Address?> getEstablishmentAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.establishment,
    );
  }

  @override
  Future<Address?> getNeighborhoodAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.neighborhood,
    );
  }

  @override
  Future<Address?> getPlusCodeAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) {
    return _getAddressByType(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
      addressType: AddressType.plus_code,
    );
  }
}
