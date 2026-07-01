import 'package:dio/dio.dart';
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  RetryInterceptor({required this.dio, this.maxRetries = 3});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final left = err.requestOptions.extra['retriesLeft'] as int? ?? maxRetries;
    final retry = left > 0 && (err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.receiveTimeout || err.type == DioExceptionType.connectionError);
    if (!retry) return handler.next(err);
    err.requestOptions.extra['retriesLeft'] = left - 1;
    await Future.delayed(Duration(seconds: maxRetries - left + 1));
    try { handler.resolve(await dio.fetch(err.requestOptions)); } catch (_) { handler.next(err); }
  }
}
