import 'package:citizen/exports.dart';

class AppPreferences {
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
    String? savedEmail = prefs.getString('email');
    if (savedEmail == email) {
      return false; // User already exists
    }

    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);

    await prefs.setBool('isLoggedIn', true);
    return true;
  }

  // AUTH: LogIn
  static Future<int> loginUser({
    String? email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    if (savedEmail == null) {
      return 0; // User does not exist
    }

    if ((savedEmail == email) && savedPassword == password) {
      await prefs.setBool('isLoggedIn', true);
      return 1; // Success
    }

    return 2; // Incorrect password
  }

  // Fetch Profile
  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString('name'),
      "email": prefs.getString('email'),
      "phone": prefs.getString('phone'),
    };
  }

  // Check Login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);
  }
}
