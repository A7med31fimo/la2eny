class AppConstants {
  AppConstants._();

  // App
  static const String appName = 'LocalAI';
  static const String appNameAr = 'لوكال AI';

  // Supported locales
  static const String localeEn = 'en';
  static const String localeAr = 'ar';

  // Sync
  static const String lastSyncKey = 'last_sync_timestamp';
  static const int syncPageSize = 100;
  static const int syncRetryAttempts = 3;

  // AI
  static const int maxConversationHistory = 10;
  static const int minPreferencesBeforeRecommend = 2;
  static const int maxRecommendations = 10;
  static const int aiResponseTimeoutSeconds = 30;

  // Maps
  static const double defaultLatitude = 24.7136;   // Riyadh
  static const double defaultLongitude = 46.6753;
  static const double defaultZoom = 14.0;
  static const double placeDetailZoom = 16.0;
  static const int mapCacheMaxSizeMB = 200;
  static const int mapCacheMaxAgeDays = 30;

  // Search
  static const int searchDebounceMs = 400;
  static const int maxSearchResults = 50;

  // Distance
  static const double defaultSearchRadiusKm = 10.0;
  static const List<double> distanceFilterOptions = [1.0, 2.0, 5.0, 10.0, 20.0];

  // Pagination
  static const int placesPageSize = 20;

  // Cache
  static const int imageCacheMaxMB = 100;

  // Favorites
  static const String favoritesKey = 'user_favorites';

  // Ranking weights
  static const double weightCategory = 0.35;
  static const double weightBudget = 0.20;
  static const double weightDistance = 0.20;
  static const double weightRating = 0.15;
  static const double weightOpenNow = 0.10;
}
