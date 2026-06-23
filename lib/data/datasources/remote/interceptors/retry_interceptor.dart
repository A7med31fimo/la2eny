import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final retriesLeft = err.requestOptions.extra['retriesLeft'] as int? ??
        maxRetries;

    // Only retry on network/timeout errors, not 4xx/5xx
    final shouldRetry = retriesLeft > 0 &&
        (err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionError);

    if (!shouldRetry) {
      return handler.next(err);
    }

    err.requestOptions.extra['retriesLeft'] = retriesLeft - 1;

    // Exponential backoff
    final delay = retryDelay * (maxRetries - retriesLeft + 1);
    await Future.delayed(delay);

    try {
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      handler.next(err);
    }
  }
}
