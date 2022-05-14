library flutter_address_from_latlng;

import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';
import 'package:flutter_address_from_latlng/interfaces/address_service.dart';
import 'package:flutter_address_from_latlng/models/address_response.dart';
import 'package:flutter_address_from_latlng/repository/address_repository.dart';
import 'package:flutter_address_from_latlng/utils/string_utils.dart';

/// A Calculator.
class FlutterAddressFromLatLng {
  final AddressFromLatLngInterface _instance = AddressService(
    repository: AddressRepository(),
    stringUtils: StringUtils(),
  );

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
