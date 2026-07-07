import 'package:citizen/exports.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSwitch;
  final VoidCallback onLoginSuccess;

  const LoginForm({
    super.key,
    required this.onSwitch,
    required this.onLoginSuccess,
  });

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool emailLogin = true;
  String email = '';
  String phone = '';
  String password = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          spacing: 16,
          children: [
            // Auth Fields
            CustomTextField(
              prefixIcon: emailLogin
                  ? Icons.email_rounded
                  : Icons.phone_android_rounded,
              hintText: emailLogin ? 'Email Address' : 'Phone Number',
              onChanged: (value) {
                if (emailLogin) {
                  email = value;
                } else {
                  phone = value;
                }
              },
              keyboardType: emailLogin
                  ? TextInputType.emailAddress
                  : TextInputType.phone,
            ),
            CustomTextField(
              prefixIcon: Icons.lock_rounded,
              suffixIcon: hidePassword
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              hintText: 'Password',
              obscureText: hidePassword,
              onSuffixIconPressed: () {
                setState(() => hidePassword = !hidePassword);
              },
              onChanged: (value) => setState(() => password = value),
              keyboardType: TextInputType.visiblePassword,
            ),
            PasswordValidationView(password: password),
            // Forgot Password Text
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            // Buttons
            const SizedBox(height: 8),
            AppButton(
              text: 'Login',
              onPressed: () async {
                if ((emailLogin && email.isEmpty) ||
                    (!emailLogin && phone.isEmpty) ||
                    password.isEmpty) {
                  AppToast.info(context, 'Please fill in all fields.');
                  return;
                }
                final result = await AppPreferences.loginUser(
                  email: emailLogin ? email : null,
                  password: password,
                );

                if (!context.mounted) return;

                if (result == 1) {
                  AppToast.success(context, 'Login successful! Welcome back.');
                  context.read<AuthProvider>().checkLogin();
                  widget.onLoginSuccess();
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
            const SizedBox(height: 8),
            Text(
              'or continue with',
              style: GoogleFonts.openSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: AppButton(
                    borderColor: AppColors.primary.withOpacity(0.2),
                    backgroundColor: Colors.white,
                    textColor: AppColors.textPrimary,
                    text: 'Google',
                    onPressed: () {
                      // Handle Google login
                    },
                  ),
                ),
                Expanded(
                  child: AppButton(
                    borderColor: AppColors.primary.withOpacity(0.2),
                    backgroundColor: Colors.white,
                    textColor: AppColors.textPrimary,
                    prefixIcon: Icon(
                      emailLogin
                          ? Icons.phone_android_rounded
                          : Icons.email_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    text: emailLogin ? 'Phone' : 'Email',
                    onPressed: () {
                      setState(() => emailLogin = !emailLogin);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AuthFooter(
              text: 'New to CivicWatch? ',
              ctaText: 'Register',
              onTap: widget.onSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
