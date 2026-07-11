import 'package:citizen/exports.dart';

class AppPreferences {
  AppPreferences._();

  static const _imageKey = 'profileImage';
  static const _nameKey = 'name';
  static const _usernameKey = 'username';
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
  static const _onboardingKey = "hasSeenOnboarding";

  static String _generateUsername(String email) {
    if (email.isEmpty) return '';
    return email.split('@')[0].toLowerCase().trim();
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// AUTH: SignUp
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

    final savedEmail = prefs.getString(_emailKey);
    if (savedEmail == email) {
      return false; // User already exists
    }

    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_usernameKey, _generateUsername(email));
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

  /// AUTH: LogIn
  static Future<int> loginUser({
    String? email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString(_emailKey);
    final savedPassword = prefs.getString(_passwordKey);

    if (savedEmail == null) {
      return 0; // User does not exist
    }

    if ((savedEmail == email) && savedPassword == password) {
      await prefs.setBool(_logKey, true);
      return 1; // Success
    }

    return 2; // Incorrect password
  }

  /// Fetch Profile
  static Future<Map<String, dynamic>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString(_usernameKey);
    final email = prefs.getString(_emailKey);

    if (username == null && email != null) {
      username = _generateUsername(email);
      await prefs.setString(_usernameKey, username);
    }

    return {
      "name": prefs.getString(_nameKey),
      "username": username,
      "email": email,
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

  /// Check Login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_logKey) ?? false;
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_usernameKey);
    await prefs.setBool(_logKey, false);
  }

  /// Update Civic Points
  static Future<void> addCivicPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final currentPoints = prefs.getInt(_civicPoints) ?? 0;
    await prefs.setInt(_civicPoints, currentPoints + points);
  }

  /// Update User Profile
  static Future<void> updateUserProfile({
    required String name,
    required String phone,
    String? username,
    String? imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, name);
    await prefs.setString(_phoneKey, phone);
    if (username != null) {
      await prefs.setString(_usernameKey, username);
    }
    if (imagePath != null) {
      if (imagePath.isEmpty) {
        await prefs.remove(_imageKey);
      } else {
        await prefs.setString(_imageKey, imagePath);
      }
    }
  }

  /// Username Methods
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<void> clearUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
  }

  /// Notification Preferences
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
