class ApiConstants {
  ApiConstants._();
  static const String baseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'https://your-backend.com/api');
  static const String places = '/places';
  static const String categories = '/categories';
  static const String paramUpdatedSince = 'updated_since';
  static const String paramPage = 'page';
  static const String paramLimit = 'limit';
  static const int connectTimeoutMs = 10000;
  static const int receiveTimeoutMs = 30000;
  static const int sendTimeoutMs = 10000;
}
