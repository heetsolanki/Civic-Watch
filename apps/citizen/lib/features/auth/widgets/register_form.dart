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

  bool isPasswordValid(String password) {
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$',
    );
    return passwordRegExp.hasMatch(password);
  }

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
              AuthInput(
                prefixIcon: Icons.person,
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              AuthInput(
                prefixIcon: Icons.email,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              AuthInput(
                prefixIcon: Icons.phone_android,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
              AuthInput(
                prefixIcon: Icons.password,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off,
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
              ),
              AuthInput(
                prefixIcon: Icons.password,
                hintText: 'Confirm Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword,
                suffixIcon: hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                onSuffixIconPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                    passwordMatch = confirmPassword == password;
                  });
                },
              ),
              PasswordValidationView(password: password),
              const SizedBox(height: 10),
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

                  if (!isPasswordValid(password)) {
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

                  bool success = await AppPreferences.createUser(
                    name: name,
                    email: email,
                    password: confirmPassword,
                    phone: phone,
                  );
                  if (success) {
                    AppToast.success(
                      context,
                      'Account created! Welcome to the community.',
                    );
                    context.read<AuthProvider>().refreshAuth();
                    context.go('/main');
                  } else {
                    AppToast.error(
                      context,
                      'Email already registered. Try logging in.',
                    );
                  }
                },
              ),
              AuthFooter(
                text: 'Already contributing? ',
                ctaText: 'Login',
                onTap: widget.onSwitch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
