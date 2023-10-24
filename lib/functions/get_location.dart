import 'package:geolocator/geolocator.dart';


Future<Position?> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle denied permission forever
    return null;
  }

  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }
  return null;
}

// Future<void> openAppSettings() async {
//   if (await Permission.location.isPermanentlyDenied) {
//     // Check if the location permission is permanently denied
//     final packageInfo = await PackageInfo.fromPlatform();
//     // Open the app settings for your app
//     await openAppSettings();
//   }
// }
