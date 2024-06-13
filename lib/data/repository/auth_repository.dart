class AuthRepository {
  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> register(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
