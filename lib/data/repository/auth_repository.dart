import 'package:game_player_client/data/models/user.dart';
import 'package:game_player_client/data/storage/token_storage.dart';
import 'package:game_player_client/data/storage/user_storage.dart';

class AuthRepository {
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  AuthRepository(this._tokenStorage, this._userStorage);

  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    await _tokenStorage.setToken('token');
  }

  Future<void> register(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    await _tokenStorage.setToken('token');
  }

  Future<void> logout() async {
    await _tokenStorage.clear();
  }

  Future<void> fetchUser() async {
    await Future.delayed(const Duration(seconds: 2));
    _userStorage.set(
      const User(
        username: 'Daniil',
        avatar: 'https://i.pravatar.cc/300',
      ),
    );
  }

  Stream<User?> watchUser() => _userStorage.watch();
}
