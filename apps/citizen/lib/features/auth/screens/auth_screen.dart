import 'package:citizen/exports.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void changeAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: auth.isLoggedIn
                ? [const ProfileScreen()]
                : [
                    const SizedBox(width: double.infinity, height: 30),
                    AuthHeader(
                      title: isLogin ? 'Welcome Back!' : 'Create Account',
                      subtitle: isLogin
                          ? 'Report Issues. Improve your city.'
                          : 'Join citizens in improving your city.',
                    ),
                    isLogin
                        ? LoginForm(onSwitch: changeAuthMode)
                        : RegisterForm(onSwitch: changeAuthMode),
                  ],
          ),
        ),
      ),
    );
  }
}
