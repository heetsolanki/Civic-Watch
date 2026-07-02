import 'package:citizen/exports.dart';

class AuthScreen extends StatefulWidget {
  final bool showBackButton;

  const AuthScreen({super.key, this.showBackButton = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void changeAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.showBackButton
            ? IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back),
              )
            : null,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity, height: 30),
              AuthHeader(
                title: isLogin ? 'Welcome Back!' : 'Create Account',
                subtitle: isLogin
                    ? 'Report Issues. Improve your city.'
                    : 'Join citizens in improving your city.',
              ),
              isLogin
                  ? LoginForm(
                      onSwitch: changeAuthMode,
                      onLoginSuccess: () {
                        context.pop(true);
                      },
                    )
                  : RegisterForm(onSwitch: changeAuthMode),
            ],
          ),
        ),
      ),
    );
  }
}
