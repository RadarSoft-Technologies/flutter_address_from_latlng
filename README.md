Provide convenient way to get address from latitude and longitude.
Also provide various methods to get address by types.

## Features

* Get most detailed formatted address
* Get Premise address
* Get Street address
* Get Route Address
* Many more ...

## Getting started

Include dependency in your pubspec.yaml file

```yml
dependencies:
  flutter:
    sdk: flutter
  # add flutter_address_from_latlng
  flutter_address_from_latlng: ^(updated version)
```

## Usage

Import package to user in your dart file

```dart
import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';
```

To get formatted address

```dart
String formattedAddress = await FlutterAddressFromLatLng().getFormattedAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get Premise address

```dart
Address? address = await FlutterAddressFromLatLng().getPremiseAddress(
  latitude: latitude,
  longitude: longitude,
  googleApiKey: googleApiKey,
);
```

To get Street address

```dart
Address? streetAddress = await FlutterAddressFromLatLng().getStreetAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get Direction address

```dart
Address? directionAddress = await FlutterAddressFromLatLng().getDirectionAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get Establishment address 
```dart
Address? establishmentAddress = await FlutterAddressFromLatLng().getEstablishmentAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get PlusCode address

```dart
Address? plusCodeAddress = await FlutterAddressFromLatLng().getPlusCodeAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get Neighborhood address

```dart
Address? neighborHoodAddress = await FlutterAddressFromLatLng().getNeighborhoodAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get level 1 Administrative address

```dart
Address? administrativeArea1 = await FlutterAddressFromLatLng().getAdministrativeAddress1(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get level 2 Administrative address

```dart
Address? administrativeArea2 = await FlutterAddressFromLatLng().getAdministrativeAddress2(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get level 3 Administrative address

```dart
Address? administrativeArea3 = await FlutterAddressFromLatLng().getAdministrativeAddress3(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

To get Country address

```dart
Address? countryAddress = await FlutterAddressFromLatLng().getCountryAddress(
  latitude: YOUR_LATITUDE,
  longitude: YOUR_LONGITUDE,
  googleApiKey: googleApiKey,
);
```

## Additional information

Contribution or any suggestion are warm welcome. Please keep eay on git repo for any kind of information update.
