library flutter_address_from_latlng;

import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';
import 'package:flutter_address_from_latlng/interfaces/address_service.dart';
import 'package:flutter_address_from_latlng/repository/address_repository.dart';
import 'package:flutter_address_from_latlng/utils/string_utils.dart';

/// A Calculator.
class FlutterAddressFromLatLng {
  final AddressFromLatLngInterface _instance = AddressService(
    repository: AddressRepository(),
    stringUtils: StringUtils(),
  );

  Future<String> t(double latitude, double longitude, String googleApiKey) async {
    return _instance.getFormattedAddress(
      latitude: latitude,
      longitude: longitude,
      gApiKey: googleApiKey,
    );
  }
}
