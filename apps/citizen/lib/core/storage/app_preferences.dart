import 'package:citizen/exports.dart';

class AppPreferences {
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
  static const _logKey = 'isLoggedIn';

  // ONBOARDING
  static const String _onboardingKey = "hasSeenOnboarding";

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  // AUTH: SignUp
  static Future<bool> createUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Simple check: if email is already saved, user exists
    String? savedEmail = prefs.getString(_emailKey);
    if (savedEmail == email) {
      return false; // User already exists
    }

    await prefs.setString('name', name);
    await prefs.setString(_emailKey, email);
    await prefs.setString('phone', phone);
    await prefs.setString(_passwordKey, password);

    await prefs.setBool(_logKey, true);
    return true;
  }

  // AUTH: LogIn
  static Future<int> loginUser({
    String? email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString(_emailKey);
    String? savedPassword = prefs.getString(_passwordKey);

    if (savedEmail == null) {
      return 0; // User does not exist
    }

    if ((savedEmail == email) && savedPassword == password) {
      await prefs.setBool(_logKey, true);
      return 1; // Success
    }

    return 2; // Incorrect password
  }

  // Fetch Profile
  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString('name'),
      "email": prefs.getString(_emailKey),
      "phone": prefs.getString('phone'),
    };
  }

  // Check Login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_logKey) ?? false;
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_logKey, false);
  }
}
