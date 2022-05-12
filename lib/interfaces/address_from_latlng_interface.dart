abstract class AddressFromLatLngInterface {
  Future<String> getMostPerfectAddress({
    required double latitude,
    required double longitude,
    required String gApiKey,
  });
}
