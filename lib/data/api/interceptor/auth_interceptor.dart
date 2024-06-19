import 'package:dio/dio.dart';
import 'package:game_player_client/data/storage/token_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = _tokenStorage.token;
    if (accessToken != null) {
      options.headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401 || response.statusCode == 403) {
      await _tokenStorage.clear();
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: 'Unauthorized',
          response: response,
        ),
      );
      return;
    }
    super.onResponse(response, handler);
  }
}
