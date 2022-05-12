import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';

void main() {

  test(
    'Test 1: Location from coordinate',
        () async {
      String res = await FlutterAddressFromLatLng().t(
        23.832351, 90.418158,
        'AIzaSyC6CmCq98mNH45TLTe7-HewwvDwUKVUJZ4',
      );
      print(res);

      expect(res, '');
    },
  );

}
