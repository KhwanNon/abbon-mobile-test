import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMapWithCurrentLocation() async {
  try {
    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) return;
    // Check and request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // Exit the function if permission is denied
      if (permission == LocationPermission.denied) return;
    }
    // Exit the function if permission is permanently denied
    if (permission == LocationPermission.deniedForever) return;
    // Get the current position of the user
    Position position = await Geolocator.getCurrentPosition();
    // Construct the Google Maps URL to open the user's location
    final String googleMapsUrl =
        'http://maps.google.com/maps?q=${position.latitude},${position.longitude}';
    // Open Google Maps with the constructed URL
    await launchUrl(Uri.parse(googleMapsUrl), mode: LaunchMode.externalApplication);
  } catch (e) {
    // Catch any errors and print them to the debug console
    // ignore: avoid_print
    print('Map launch error: $e');
  }
}
