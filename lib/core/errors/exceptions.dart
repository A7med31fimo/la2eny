/// Thrown when a network request fails (no connectivity)
class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'No internet connection']);

  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when the API returns an error response
class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Thrown when parsing API response fails
class ParseException implements Exception {
  final String message;
  const ParseException([this.message = 'Failed to parse response']);

  @override
  String toString() => 'ParseException: $message';
}

/// Thrown when a local database operation fails
class DatabaseException implements Exception {
  final String message;
  const DatabaseException([this.message = 'Database error']);

  @override
  String toString() => 'DatabaseException: $message';
}

/// Thrown when the AI engine fails to initialize or respond
class AiException implements Exception {
  final String message;
  const AiException([this.message = 'AI engine error']);

  @override
  String toString() => 'AiException: $message';
}

/// Thrown when authentication fails or token is invalid
class AuthException implements Exception {
  final String message;
  const AuthException([this.message = 'Authentication failed']);

  @override
  String toString() => 'AuthException: $message';
}

/// Thrown when device location is unavailable
class LocationException implements Exception {
  final String message;
  const LocationException([this.message = 'Location unavailable']);

  @override
  String toString() => 'LocationException: $message';
}
