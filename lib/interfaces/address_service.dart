import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';
import 'package:flutter_address_from_latlng/models/address_types.dart';
import 'package:flutter_address_from_latlng/repository/address_repository.dart';
import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';
import 'package:flutter_address_from_latlng/utils/string_utils.dart';
import '../models/address_response.dart';

/// This class is the implementation of [AddressFromLatLngInterface]
///
///
/// Implements all logical methods provided by [FlutterAddressFromLatLng]
class AddressService implements AddressFromLatLngInterface {
  /// instance of [AddressRepository] used for getting data from network
  final AddressRepository repository;

  /// A utility class
  ///
  /// Provide string related utility methods to boost up development
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
    if (myAddress == null ||
        myAddress.status != 'OK' ||
        myAddress.results.isEmpty) {
      return '';
    }

    List<String> streetAddressList = [];
    List<String> premiseAddressList = [];
    List<String> subLocalityAddressList = [];
    List<String> establishmentAddressList = [];

    for (Address result in myAddress.results) {
      if (result.types.contains('street_address')) {
        streetAddressList.add(result.formattedAddress ?? '');
      }

      if (result.types.contains('premise')) {
        premiseAddressList.add(result.formattedAddress ?? '');
      }
      if (result.types.contains('establishment')) {
        establishmentAddressList.add(result.formattedAddress ?? '');
      }

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

    String premiseAddress =
        stringUtils.getMaxStringFromList(premiseAddressList);
    String streetAddress = stringUtils.getMaxStringFromList(streetAddressList);
    String subLocalityAddress =
        stringUtils.getMaxStringFromList(subLocalityAddressList);
    String establishmentAddress =
        stringUtils.getMaxStringFromList(establishmentAddressList);
    String firstAddress = myAddress.results[0].formattedAddress ?? '';

    List<String> tempList = [
      premiseAddress,
      streetAddress,
      subLocalityAddress,
      establishmentAddress,
      firstAddress
    ];

    return stringUtils.getMaxStringFromList(tempList);
  }

  /// returns a string [key] according to given [addressType]
  String getKeyByType(AddressType addressType) {
    switch (addressType) {
      case AddressType.premise:
        return 'premise';
      case AddressType.street_address:
        return 'street_address';
      case AddressType.establishment:
        return 'establishment';
      case AddressType.plus_code:
        return 'plus_code';
      case AddressType.route:
        return 'route';
      case AddressType.neighborhood:
        return 'neighborhood';
      case AddressType.administrative_area_level_1:
        return 'administrative_area_level_1';
      case AddressType.administrative_area_level_2:
        return 'administrative_area_level_2';
      case AddressType.administrative_area_level_3:
        return 'administrative_area_level_3';
      case AddressType.country:
        return 'country';
      default:
        return '';
    }
  }

  /// This method returns an address from given [addressList] if any address
  /// match with the given [addressType] if exist in [addressList]
  ///
  /// if address is not present in [addressList] then return null
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

    if (myAddress == null) {
      print('returning null 1');
      return null;
    }

    for (var v in myAddress.results) {
      if (v.types.contains(getKeyByType(addressType))) {
        return v;
      }
    }
    return null;
  }

  /// Returns a best formatted address
  ///
  /// best formatted address is the address that is best defined among a list
  /// of address
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Return premise address if available else returns null
  ///
  /// premise address indicates a named location, usually a building
  /// or collection of buildings with a common name.
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns street address if available else returns null
  ///
  /// street address indicates a precise street address with street information.
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns route address if available else returns null
  ///
  /// routes address indicates a named route
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Return establishment address if available else return null
  ///
  /// ESTABLISHMENT typically indicates a place that has not yet
  /// been categorized.
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns plus_code address if available else returns null
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns NeighborHood address if available else returns null
  ///
  /// NeighborHood address indicate the well known neighborhood hood address
  /// near the given [latitude],[longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns the administrative address level 1 information
  /// of provided [latitude], [longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns the administrative address level 2 information
  /// of provided [latitude], [longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// Returns the administrative address level 3 information
  /// of provided [latitude], [longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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

  /// return Country Address if available else returns null
  ///
  /// COUNTRY indicates the national political entity,
  /// and is typically the highest order type returned by the Geocoder
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
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
}
