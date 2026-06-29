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
        return const MainShell(
          initialIndex: 0,
        );
      },
    ),
    GoRoute(
      path: '/profile',
      name: "Profile",
      builder: (context, state) {
        return const MainShell(
          initialIndex: 4,
        );
      },
    ),
    GoRoute(
      path: '/auth',
      name: "Auth Screen",
      builder: (context, state) {
        return const MainShell(
          initialIndex: 3,
        );
      },
    ),
    GoRoute(
      path: '/create-report',
      name: "Create Report",
      builder: (context, state) {
        return const CreateReportScreen();
      },
    ),
  ],
);
