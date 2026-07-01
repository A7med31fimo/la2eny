class AppConstants {
  AppConstants._();
  static const String appName = 'LocalAI';
  static const String localeEn = 'en';
  static const String localeAr = 'ar';
  static const String lastSyncKey = 'last_sync_timestamp';
  static const int syncPageSize = 100;
  static const int maxConversationHistory = 10;
  static const int minPreferencesBeforeRecommend = 2;
  static const int maxRecommendations = 10;
  static const double defaultLatitude = 24.7136;
  static const double defaultLongitude = 46.6753;
  static const double defaultZoom = 14.0;
  static const double placeDetailZoom = 16.0;
  static const double defaultSearchRadiusKm = 10.0;
  static const List<double> distanceFilterOptions = [1.0, 2.0, 5.0, 10.0, 20.0];
  static const int searchDebounceMs = 400;
}
