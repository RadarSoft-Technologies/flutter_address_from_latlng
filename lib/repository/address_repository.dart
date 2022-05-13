import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/my_address.dart';

class AddressRepository {
  /// This method makes a network call using[http] library and get an address list
  /// from google [geocoding] api and returns a list of [Results] in [MyAddress] model
  ///
  /// [latitude] the latitude of the place that we wand to get address
  /// [longitude] the longitude of the place that we want to get address
  /// [gApiKey] is the key to access Google Geo APIs
  Future<MyAddress?> getAddressFromCoordinate({
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
}
