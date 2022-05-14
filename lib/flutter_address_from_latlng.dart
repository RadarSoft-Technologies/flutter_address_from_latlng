library flutter_address_from_latlng;

import 'package:flutter_address_from_latlng/interfaces/base_address_arvice.dart';
import 'package:flutter_address_from_latlng/interfaces/address_service.dart';
import 'package:flutter_address_from_latlng/models/address_response.dart';
import 'package:flutter_address_from_latlng/repository/address_repository.dart';
import 'package:flutter_address_from_latlng/src/string_utils.dart';

/// The main class of our library
/// 
/// This is the class that provide all methods related to find location
/// from latitude and longitude
class FlutterAddressFromLatLng {
  /// Create an [_instance] of [AddressService] 
  /// 
  /// [AddressService] provide implementation of [BaseAddressService]
  final BaseAddressService _instance = AddressService(
    repository: AddressRepository(),
    stringUtils: StringUtils(),
  );

  /// Makes an HTTP get request and returns a formatted address from
  /// an address list that are found from google geocoding api
  ///
  /// if address is not present in [addressList] then return 
  /// an empty string
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<String> getFormattedAddress(
    double latitude,
    double longitude,
    String googleApiKey,
  ) async {
    return _instance.getFormattedAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: googleApiKey,
    );
  }

  /// Return premise address if available else returns null
  ///
  /// premise address indicates a named location, usually a building
  /// or collection of buildings with a common name.
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getPremiseAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getPremiseAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  /// Returns street address if available else returns null
  ///
  /// street address indicates a precise street address with street information.
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getStreetAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getStreetAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  Future<Address?> getDirectionAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getDirectionAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  /// Returns route address if available else returns null
  ///
  /// routes address indicates a named route
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getEstablishmentAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getEstablishmentAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  /// Returns plus_code address if available else returns null
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getPlusCodeAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getPlusCodeAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
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
  Future<Address?> getNeighborhoodAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getNeighborhoodAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  /// Returns the administrative address level 1 information
  /// of provided [latitude], [longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getAdministrativeAddress1({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getAdministrativeAddress1(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  /// Returns the administrative address level 2 information
  /// of provided [latitude], [longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getAdministrativeAddress2({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getAdministrativeAddress2(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }

  /// Returns the administrative address level 3 information
  /// of provided [latitude], [longitude]
  ///
  /// [latitude] is the latitude of desired address
  /// [longitude] is the longitude of desired address
  /// [gApiKey] the api key to get access of google geocoding apis
  Future<Address?> getAdministrativeAddress3({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getAdministrativeAddress3(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
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
  Future<Address?> getCountryAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  }) async {
    return _instance.getCountryAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: gApiKey,
    );
  }
}
