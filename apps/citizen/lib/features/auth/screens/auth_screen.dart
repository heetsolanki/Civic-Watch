import 'package:citizen/exports.dart';

class AuthScreen extends StatefulWidget {
  final bool showBackButton;
  final bool showAppBar;

  const AuthScreen({
    super.key,
    this.showBackButton = false,
    this.showAppBar = true,
  });

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
      extendBodyBehindAppBar: true,
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: widget.showBackButton
                  ? IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  : null,
            )
          : null,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity, height: widget.showAppBar ? 30 : 10),
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
                      if (context.canPop()) {
                        context.pop(true);
                      } else {
                        context.go('/main');
                      }
                    },
                  )
                : RegisterForm(onSwitch: changeAuthMode),
          ],
        ),
      ),
    );
  }
}
