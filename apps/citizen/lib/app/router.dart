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
      pageBuilder: (context, state) =>
          _customTransition(child: const AccountScreen(), state: state),
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
    GoRoute(
      path: '/report-success',
      name: "reportSuccess",
      builder: (context, state) => const ReportSuccessScreen(),
    ),
    GoRoute(path: '/auth', name: 'auth', builder: (_, _) => AuthScreen()),

    // Profile Routers
    GoRoute(
      path: '/edit-profile',
      name: 'editProfile',
      pageBuilder: (context, state) =>
          _customTransition(child: const EditProfileScreen(), state: state),
    ),
    GoRoute(
      path: '/preferences',
      name: 'preferences',
      pageBuilder: (context, state) =>
          _customTransition(child: const PreferencesScreen(), state: state),
    ),
    GoRoute(
      path: '/help-support',
      name: 'helpSupport',
      pageBuilder: (context, state) =>
          _customTransition(child: const HelpSupportScreen(), state: state),
    ),
    GoRoute(
      path: '/privacy-policy',
      name: 'privacyPolicy',
      pageBuilder: (context, state) =>
          _customTransition(child: const PrivacyPolicyScreen(), state: state),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      pageBuilder: (context, state) =>
          _customTransition(child: const TermsConditionsScreen(), state: state),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      pageBuilder: (context, state) =>
          _customTransition(child: const AboutScreen(), state: state),
    ),
  ],
);

CustomTransitionPage _customTransition({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.08, 0), // 8% horizontal slide
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
