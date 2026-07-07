import 'package:citizen/exports.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onSwitch;

  const RegisterForm({super.key, required this.onSwitch});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  bool passwordMatch = true;
  bool hidePassword = true;

  bool _isPasswordValid(String password) {
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$',
    );
    return passwordRegExp.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          spacing: 16,
          children: [
            CustomTextField(
              prefixIcon: Icons.person_rounded,
              hintText: 'Full Name',
              keyboardType: TextInputType.name,
              onChanged: (value) => setState(() => name = value),
            ),
            CustomTextField(
              prefixIcon: Icons.email_rounded,
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => setState(() => email = value),
            ),
            CustomTextField(
              prefixIcon: Icons.phone_android_rounded,
              hintText: 'Phone Number',
              keyboardType: TextInputType.phone,
              onChanged: (value) => setState(() => phone = value),
            ),
            CustomTextField(
              prefixIcon: Icons.lock_rounded,
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: hidePassword
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              obscureText: hidePassword,
              onSuffixIconPressed: () {
                setState(() => hidePassword = !hidePassword);
              },
              onChanged: (value) => setState(() => password = value),
            ),
            CustomTextField(
              prefixIcon: Icons.lock_outline_rounded,
              hintText: 'Confirm Password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: hidePassword,
              suffixIcon: hidePassword
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              onSuffixIconPressed: () {
                setState(() => hidePassword = !hidePassword);
              },
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                  passwordMatch = confirmPassword == password;
                });
              },
            ),
            PasswordValidationView(password: password),
            const SizedBox(height: 8),
            AppButton(
              text: 'Start Contributing!',
              onPressed: () async {
                if (name.isEmpty ||
                    email.isEmpty ||
                    phone.isEmpty ||
                    password.isEmpty) {
                  AppToast.info(context, 'Please fill in all fields.');
                  return;
                }

                if (!_isPasswordValid(password)) {
                  AppToast.error(
                    context,
                    'Password does not meet safety requirements.',
                  );
                  return;
                }

                if (!passwordMatch) {
                  AppToast.error(context, 'Passwords do not match.');
                  return;
                }

                final success = await AppPreferences.createUser(
                  name: name,
                  email: email,
                  password: confirmPassword,
                  phone: phone,
                );

                if (!context.mounted) return;

                if (success) {
                  AppToast.success(
                    context,
                    'Account created! Welcome to the community.',
                  );
                  context.read<AuthProvider>().checkLogin();
                  context.go('/main');
                } else {
                  AppToast.error(
                    context,
                    'Email already registered. Try logging in.',
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            AuthFooter(
              text: 'Already contributing? ',
              ctaText: 'Login',
              onTap: widget.onSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
