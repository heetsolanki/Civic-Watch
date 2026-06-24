import 'package:citizen/exports.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSwitch;

  const LoginForm({super.key, required this.onSwitch});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool emailLogin = true;
  String phone = '';
  String email = '';
  String password = '';
  bool isPassword = true;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            spacing: 16,
            children: [
              // Auth Fields
              AuthInput(
                prefixIcon: emailLogin ? Icons.email : Icons.phone_android,
                hintText: emailLogin ? 'Email Address' : 'Phone Number',
                onChanged: (value) {
                  emailLogin ? email = value : phone = value;
                },
                keyboardType: emailLogin
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
              ),
              AuthInput(
                prefixIcon: Icons.password,
                suffixIcon: hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                hintText: 'Password',
                obscureText: hidePassword,
                onSuffixIconPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              PasswordValidationView(password: password),
              // Forgot Password Text
              Text(
                'Forgot Password?',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.5,
                  decorationColor: AppColors.primary,
                ),
              ),
              // Buttons
              const SizedBox(height: 10),
              AppButton(
                text: 'Login',
                onPressed: () async {
                  if (email.isEmpty || password.isEmpty) {
                    AppToast.info(context, 'Please fill in all fields.');
                    return;
                  }
                  int result = await AppPreferences.loginUser(
                    email: email,
                    password: password,
                  );

                  if (result == 1) {
                    AppToast.success(
                      context,
                      'Login successful! Welcome back.',
                    );
                    context.read<AuthProvider>().refreshAuth();
                    context.go('/main');
                  } else if (result == 0) {
                    AppToast.error(
                      context,
                      'Account does not exist. Please register.',
                    );
                  } else {
                    AppToast.error(
                      context,
                      'Incorrect password. Please try again.',
                    );
                  }
                },
              ),
              Text(
                'or continue with',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: AppButton(
                      borderColor: AppColors.primary,
                      backgroundColor: AppColors.cardColor,
                      textColor: AppColors.textPrimary,
                      text: 'Google',
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      borderColor: AppColors.primary,
                      backgroundColor: AppColors.cardColor,
                      textColor: AppColors.textPrimary,
                      prefixIcon: emailLogin
                          ? Icon(Icons.phone_android)
                          : Icon(Icons.email),
                      text: emailLogin ? 'Phone' : 'Email',
                      onPressed: () {
                        setState(() {
                          emailLogin = !emailLogin;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AuthFooter(
                text: 'New to CivicWatch? ',
                ctaText: 'Register',
                onTap: widget.onSwitch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
