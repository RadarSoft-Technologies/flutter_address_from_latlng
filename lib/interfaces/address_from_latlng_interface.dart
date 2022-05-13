abstract class AddressFromLatLngInterface {
  Future<String> getFormattedAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });
}
