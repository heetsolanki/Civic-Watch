import 'package:citizen/core/constants/app_colors.dart';
import 'package:citizen/core/widgets/button.dart';
import 'package:citizen/features/onboarding/screens/onboarding_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/storage/app_preferences.dart';
import '../../home/home_screen.dart';
import 'onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  await AppPreferences.setOnboardingComplete();

                  if (!context.mounted) return;

                  context.go('/home');
                },
                child: Text(
                  "Skip",
                  style: GoogleFonts.caladea(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = onboardingItems[index];

                  return OnboardingPage(
                    title: item.title,
                    description: item.description,
                    image: item.image,
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingItems.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  height: 8,
                  width: currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? AppColors.primary
                        : AppColors.textSecondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppButton(
                text: currentPage == onboardingItems.length - 1
                    ? "Explore Civic Watch"
                    : "Next",
                onPressed: () async {
                  if (currentPage == onboardingItems.length - 1) {
                    await AppPreferences.setOnboardingComplete();

                    if (!context.mounted) return;

                    context.go('/home');
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
