import 'dart:convert';

import 'package:http/http.dart' as http;

import 'address_response.dart';

/// A repository class
///
/// Provide functionality to making HTTP call to Google Geocode Api
class AddressRepository {
  /// This method makes a http get call using[http] library and get an address list
  /// from google [geocoding] api and returns a list of [Address] in [AddressResponse] model
  ///
  /// [latitude] the latitude of the place that we wand to get address
  /// [longitude] the longitude of the place that we want to get address
  /// [googleApiKey] is the key to access Google Geo APIs
  Future<AddressResponse?> getAddressFromCoordinate({
    required double latitude,
    required double longitude,
    required String googleApiKey,
  }) async {
    try {
      final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return AddressResponse.fromJson(jsonDecode(response.body));
      }
    } catch (error) {
      return null;
    }
    return null;
  }
}
