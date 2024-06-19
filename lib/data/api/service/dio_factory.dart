import 'package:dio/dio.dart';
import 'package:game_player_client/data/api/interceptor/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio createAppDio(AuthInterceptor authInterceptor) {
  final dio = Dio();
  dio.interceptors.addAll([
    authInterceptor,
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ),
  ]);
  return dio;
}
