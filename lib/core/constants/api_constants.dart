class ApiConstants {
  ApiConstants._();

  // Injected at build time via --dart-define=API_BASE_URL=https://...
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://your-backend.com/api',
  );

  static const String apiVersion = '/v1';

  // Endpoints
  static const String places = '/places';
  static const String categories = '/categories';
  static const String authGoogle = '/auth/google';
  static const String authApple = '/auth/apple';
  static const String authRefresh = '/auth/refresh';
  static const String userFavorites = '/user/favorites';

  // Query params
  static const String paramUpdatedSince = 'updated_since';
  static const String paramPage = 'page';
  static const String paramLimit = 'limit';

  // Timeouts
  static const int connectTimeoutMs = 10000;
  static const int receiveTimeoutMs = 30000;
  static const int sendTimeoutMs = 10000;
}
