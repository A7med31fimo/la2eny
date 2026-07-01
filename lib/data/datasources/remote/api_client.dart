import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class ApiClient {
  late final Dio _dio;
  ApiClient({String? baseUrl, Dio? dio}) {
    _dio = dio ?? Dio(BaseOptions(
      baseUrl: baseUrl ?? ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeoutMs),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeoutMs),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ));
    _dio.interceptors.addAll([AuthInterceptor(), RetryInterceptor(dio: _dio)]);
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try { return await _dio.get<T>(path, queryParameters: queryParameters); }
    on DioException catch (e) { throw _handle(e); }
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    try { return await _dio.post<T>(path, data: data); }
    on DioException catch (e) { throw _handle(e); }
  }

  Exception _handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError: return const NetworkException();
      case DioExceptionType.badResponse:
        return ApiException(statusCode: e.response?.statusCode ?? 0,
          message: e.response?.data?['message'] as String? ?? 'Server error');
      default: return const NetworkException();
    }
  }
}
