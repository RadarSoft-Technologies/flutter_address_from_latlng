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

  Future<Address?> getEstablishmentAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getPlusCodeAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getNeighborhoodAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getAdministrativeAddress1({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getAdministrativeAddress2({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getAdministrativeAddress3({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });

  Future<Address?> getCountryAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });
}
