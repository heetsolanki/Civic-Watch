import 'package:citizen/exports.dart';

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
      path: '/main',
      name: "Main",
      builder: (context, state) {
        return const MainShell();
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
