import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  static const _storage = FlutterSecureStorage();
  static const _key = 'auth_token';

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: _key);
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) _storage.delete(key: _key);
    handler.next(err);
  }

  static Future<void> saveToken(String token) => _storage.write(key: _key, value: token);
  static Future<void> clearToken() => _storage.delete(key: _key);
  static Future<String?> getToken() => _storage.read(key: _key);
}
