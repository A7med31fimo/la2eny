import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';

class UserLocation {
  final double latitude, longitude;
  const UserLocation({required this.latitude, required this.longitude});
}

final userLocationProvider = FutureProvider<UserLocation?>((ref) async {
  try {
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return _def();
      }
    }
    if (perm == LocationPermission.deniedForever) return _def();
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 5),
      ),
    );
    return UserLocation(latitude: pos.latitude, longitude: pos.longitude);
  } catch (_) {
    return _def();
  }
});

UserLocation _def() => const UserLocation(
  latitude: AppConstants.defaultLatitude,
  longitude: AppConstants.defaultLongitude,
);
