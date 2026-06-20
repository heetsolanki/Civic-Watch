import 'package:citizen/features/onboarding/widgets/onboarding_screen.dart';
import 'package:citizen/features/splash/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "Splash Screen",
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/onboard',
      name: "Onboarding Screen",
      builder: (context, state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: '/home',
      name: "Home",
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
  ],
);
