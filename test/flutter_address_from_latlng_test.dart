import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';

import 'lat_lng_tm.dart';

void main() {
  test(
    'Test 1: Location from coordinate',
    () async {

      List<LatLngTM> lllist = [
        LatLngTM(23.832351, 90.418158), /// nikunja
        LatLngTM(23.865757, 90.391311), /// uttara sector 11
        LatLngTM(23.870197, 90.396986), /// uttara sector 7 park
        LatLngTM(23.725156, 90.412210), /// gulistan patal sarak
        LatLngTM(23.542659, 90.784850), /// gouripur bazar school road
      ];

      for(var v in lllist){
        String res = await FlutterAddressFromLatLng().t(
          v.lat,
          v.lng,
          'AIzaSyC6CmCq98mNH45TLTe7-HewwvDwUKVUJZ4',
        );
        print(res);
        break;
      }

      expect('', '');
    },
  );
}
