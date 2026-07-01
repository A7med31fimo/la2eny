class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'No internet connection']);
  @override String toString() => 'NetworkException: \$message';
}
class ApiException implements Exception {
  final int statusCode;
  final String message;
  const ApiException({required this.statusCode, required this.message});
  @override String toString() => 'ApiException(\$statusCode): \$message';
}
class DatabaseException implements Exception {
  final String message;
  const DatabaseException([this.message = 'Database error']);
  @override String toString() => 'DatabaseException: \$message';
}
class AiException implements Exception {
  final String message;
  const AiException([this.message = 'AI engine error']);
  @override String toString() => 'AiException: \$message';
}
class AuthException implements Exception {
  final String message;
  const AuthException([this.message = 'Authentication failed']);
  @override String toString() => 'AuthException: \$message';
}
