import 'package:geolocator/geolocator.dart';

Future<Position?> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location service is enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Check permission status
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request.',
    );
  }

  // Get current position
  return await Geolocator.getCurrentPosition();
}
