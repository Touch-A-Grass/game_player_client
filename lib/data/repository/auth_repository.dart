import 'package:game_player_client/data/api/request/auth_request.dart';
import 'package:game_player_client/data/api/request/register_request.dart';
import 'package:game_player_client/data/api/request/update_user_request.dart';
import 'package:game_player_client/data/api/service/game_client.dart';
import 'package:game_player_client/data/models/user.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/data/storage/user_storage.dart';

class AuthRepository {
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;
  final GameClient _api;

  AuthRepository(this._tokenStorage, this._userStorage, this._api) {
    fetchUser();
  }

  Future<void> login(String login, String password) async {
    final response = await _api.login(AuthRequest(login: login, password: password));
    await _tokenStorage.setToken(response.token);
    fetchUser();
  }

  Future<void> register(String login, String password) async {
    await _api.register(RegisterRequest(login: login, password: password, username: login));
    final response = await _api.login(AuthRequest(login: login, password: password));
    await _tokenStorage.setToken(response.token);
    fetchUser();
  }

  Future<void> updateUser(String username) async {
    await _api.updateUser(UpdateUserRequest(username: username));
    await fetchUser();
  }

  Future<void> logout() async {
    await _tokenStorage.clear();
  }

  Future<void> fetchUser() async {
    try {
      final user = await _api.getUser();
      _userStorage.set(user);
    } catch (_) {}
  }

  Stream<User?> watchUser() => _userStorage.watch();
}
