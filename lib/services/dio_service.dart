// dio_setup.dart

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Dio createDioWithLoggerInterceptor() {
  final logger = Logger();
  final dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      logger.i('Request: ${options.method} ${options.uri}');
      return handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      logger
          .i('Response: ${response.statusCode} ${response.requestOptions.uri}');
      return handler.next(response);
    },
    onError: (DioException error, ErrorInterceptorHandler handler) {
      logger.e(
          'Error: ${error.response?.statusCode} ${error.requestOptions.uri}');
      return handler.next(error);
    },
  ));

  return dio;
}
