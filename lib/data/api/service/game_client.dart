import 'package:dio/dio.dart';
import 'package:game_player_client/data/api/request/auth_request.dart';
import 'package:game_player_client/data/api/request/register_request.dart';
import 'package:game_player_client/data/api/request/update_user_request.dart';
import 'package:game_player_client/data/api/response/auth_response.dart';
import 'package:game_player_client/data/models/user.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'game_client.g.dart';

@RestApi(baseUrl: 'http://147.45.158.230:8080')
abstract class GameClient {
  factory GameClient(Dio dio) = _GameClient;

  @GET('/user')
  Future<User> getUser();

  @PATCH('/user')
  Future<void> updateUser(@Body() UpdateUserRequest request);

  @POST('/user')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST('/user/login')
  Future<AuthResponse> login(@Body() AuthRequest request);
}
