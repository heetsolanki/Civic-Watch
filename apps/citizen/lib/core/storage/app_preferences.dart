import 'package:citizen/exports.dart';

class AppPreferences {
  static const _imageKey = 'profileImage';
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';
  static const _passwordKey = 'password';
  static const _logKey = 'isLoggedIn';
  static const _userSinceKey = 'userSince';
  static const _civicPoints = 'civicPoints';
  static const _appNotificationsKey = 'appNotifications';
  static const _reportUpdatesKey = 'reportUpdates';
  static const _authorityMessagesKey = 'authorityMessages';
  static const _nearbyIssuesKey = 'nearbyIssues';

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
    String? userSince,
    String? imagePath,
    int? civicPoints,
    bool? appNotifications,
    bool? reportUpdates,
    bool? authorityMessages,
    bool? nearbyIssues,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Simple check: if email is already saved, user exists
    String? savedEmail = prefs.getString(_emailKey);
    if (savedEmail == email) {
      return false; // User already exists
    }

    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_phoneKey, phone);
    await prefs.setString(_passwordKey, password);
    await prefs.setString(
      _userSinceKey,
      userSince ?? DateTime.now().toIso8601String(),
    );
    await prefs.setInt(_civicPoints, civicPoints ?? 0);
    await prefs.setBool(_appNotificationsKey, appNotifications ?? true);
    await prefs.setBool(_reportUpdatesKey, reportUpdates ?? true);
    await prefs.setBool(_authorityMessagesKey, authorityMessages ?? true);
    await prefs.setBool(_nearbyIssuesKey, nearbyIssues ?? true);
    if (imagePath != null) {
      await prefs.setString(_imageKey, imagePath);
    }

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
  static Future<Map<String, dynamic>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString(_nameKey),
      "email": prefs.getString(_emailKey),
      "phone": prefs.getString(_phoneKey),
      "userSince": prefs.getString(_userSinceKey),
      "civicPoints": prefs.getInt(_civicPoints),
      "imagePath": prefs.getString(_imageKey),
      "appNotifications": prefs.getBool(_appNotificationsKey) ?? true,
      "reportUpdates": prefs.getBool(_reportUpdatesKey) ?? true,
      "authorityMessages": prefs.getBool(_authorityMessagesKey) ?? true,
      "nearbyIssues": prefs.getBool(_nearbyIssuesKey) ?? true,
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

  // Update Civic Points
  static Future<void> addCivicPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    int currentPoints = prefs.getInt(_civicPoints) ?? 0;
    await prefs.setInt(_civicPoints, currentPoints + points);
  }

  // Update User Profile
  static Future<void> updateUserProfile({
    required String name,
    required String phone,
    String? imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, name);
    await prefs.setString(_phoneKey, phone);
    if (imagePath != null) {
      if (imagePath.isEmpty) {
        await prefs.remove(_imageKey);
      } else {
        await prefs.setString(_imageKey, imagePath);
      }
    }
  }

  // Notification Preferences
  static Future<void> updatePreferences({
    required bool appNotifications,
    required bool reportUpdates,
    required bool authorityMessages,
    required bool nearbyIssues,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_appNotificationsKey, appNotifications);
    await prefs.setBool(_reportUpdatesKey, reportUpdates);
    await prefs.setBool(_authorityMessagesKey, authorityMessages);
    await prefs.setBool(_nearbyIssuesKey, nearbyIssues);
  }
}
