import 'package:citizen/exports.dart';
import 'package:citizen/features/auth/screens/auth_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: "splash",
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/onboard',
      name: "onboard",
      builder: (context, state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: '/main',
      name: "main",
      builder: (context, state) {
        return const MainShell();
      },
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) {
        return const MainShell(initialIndex: 0);
      },
    ),
    GoRoute(
      path: '/profile',
      name: "profile",
      builder: (context, state) {
        return const MainShell(initialIndex: 3);
      },
    ),
    GoRoute(
      path: '/account',
      name: "account",
      builder: (context, state) {
        return const AccountScreen();
      },
    ),
    GoRoute(
      path: '/explore-issues',
      name: "exploreIssues",
      builder: (context, state) {
        return const MainShell(initialIndex: 1);
      },
    ),
    GoRoute(
      path: '/create-report',
      name: "createReport",
      builder: (context, state) {
        return const CreateReportScreen();
      },
    ),
    GoRoute(
      path: '/view-details/:issueId',
      name: "viewDetails",
      builder: (context, state) {
        final issueId = state.pathParameters['issueId']!;
        return IssueDetailsScreen(issueId: issueId);
      },
    ),

    GoRoute(path: '/auth', name: 'auth', builder: (_, _) => AuthScreen()),
  ],
);
