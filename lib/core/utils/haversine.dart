import 'dart:math';
class Haversine {
  static const double _r = 6371.0;
  static double distanceKm({required double lat1, required double lon1, required double lat2, required double lon2}) {
    final dLat = _rad(lat2 - lat1);
    final dLon = _rad(lon2 - lon1);
    final a = sin(dLat/2)*sin(dLat/2) + cos(_rad(lat1))*cos(_rad(lat2))*sin(dLon/2)*sin(dLon/2);
    return _r * 2 * atan2(sqrt(a), sqrt(1-a));
  }
  static double _rad(double d) => d * pi / 180;
  static String formatDistance(double km) => km < 1.0 ? '\${(km*1000).round()} m' : '\${km.toStringAsFixed(1)} km';
}
