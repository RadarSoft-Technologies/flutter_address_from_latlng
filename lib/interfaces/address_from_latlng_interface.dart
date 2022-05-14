import 'package:flutter_address_from_latlng/models/address_response.dart';

abstract class AddressFromLatLngInterface {
  Future<String> getFormattedAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getPremiseAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getStreetAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getDirectionAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

}
