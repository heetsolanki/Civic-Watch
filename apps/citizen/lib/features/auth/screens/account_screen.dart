import 'package:citizen/exports.dart';
import 'package:citizen/features/auth/screens/auth_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (auth.isLoggedIn) {
      return const ProfileScreen();
    }

    return const AuthScreen(showAppBar: false);
  }
}
