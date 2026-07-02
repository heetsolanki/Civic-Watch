import 'package:citizen/exports.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    _isLoggedIn = await AppPreferences.isLoggedIn();

    notifyListeners();
  }

  Future<void> logout() async {
    await AppPreferences.logout();

    _isLoggedIn = false;
    notifyListeners();
  }
}
