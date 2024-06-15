import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  final _token = BehaviorSubject<String?>.seeded(null);

  String? get token => _token.valueOrNull;

  Stream<String?> watch() => _token.stream;

  Future<void> ensureInitialized() async {
    final prefs = await SharedPreferences.getInstance();
    _token.add(prefs.getString('token'));
  }

  Future<void> setToken(String token) async {
    _token.add(token);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<void> clear() async {
    _token.add(null);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
