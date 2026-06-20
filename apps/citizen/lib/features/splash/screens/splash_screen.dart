import 'package:citizen/features/onboarding/widgets/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/storage/app_preferences.dart';
import '../../home/home_screen.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppState();
  }

  Future<void> _checkAppState() async {
    await Future.delayed(const Duration(seconds: 2));

    final seen = await AppPreferences.hasSeenOnboarding();

    if (!mounted) return;

    if (seen) {
      context.go('/home');
    } else {
      context.go('/onboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/logo.png', height: 100),
            ),
            Text(
              'Civic Watch',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Report. Track. Resolve.',
              style: GoogleFonts.caladea(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
