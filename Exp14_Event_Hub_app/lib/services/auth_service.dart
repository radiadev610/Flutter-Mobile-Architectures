import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userSessionKey = 'app_user_session';

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.isNotEmpty && password.length >= 6) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userSessionKey, email);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userSessionKey);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userSessionKey);
  }
}