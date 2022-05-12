library flutter_address_from_latlng;

import 'package:flutter_address_from_latlng/interfaces/address_from_latlng_interface.dart';
import 'package:flutter_address_from_latlng/interfaces/address_service.dart';
import 'package:http/http.dart' as http;
import 'models/my_address.dart';

/// A Calculator.
class FlutterAddressFromLatLng {
  final AddressService _instance = AddressService();
  Future<String> t(double lat, double lng, String key)async{
    return _instance.getMostPerfectAddress(latitude: lat, longitude: lng, gApiKey: key);
  }
}
