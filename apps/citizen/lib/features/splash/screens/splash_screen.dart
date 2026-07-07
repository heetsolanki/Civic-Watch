import 'package:citizen/exports.dart';

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
      context.go('/main');
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
                color: AppColors.primary
              ),
            ),
            Text(
              'Report. Track. Resolve.',
              style: GoogleFonts.openSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
