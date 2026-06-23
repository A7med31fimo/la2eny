import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/constants/app_constants.dart';

part 'location_provider.g.dart';

class UserLocation {
  final double latitude;
  final double longitude;
  const UserLocation({required this.latitude, required this.longitude});
}

@riverpod
Future<UserLocation?> userLocation(UserLocationRef ref) async {
  try {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      if (requested == LocationPermission.denied ||
          requested == LocationPermission.deniedForever) {
        return _defaultLocation();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return _defaultLocation();
    }
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 5),
      ),
    );
    return UserLocation(latitude: pos.latitude, longitude: pos.longitude);
  } catch (_) {
    return _defaultLocation();
  }
}

UserLocation _defaultLocation() => const UserLocation(
      latitude: AppConstants.defaultLatitude,
      longitude: AppConstants.defaultLongitude,
    );
