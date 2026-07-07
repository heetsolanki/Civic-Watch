import 'package:citizen/exports.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      spacing: 25,
      children: [
        // Top trusted pill
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primary.withOpacity(0.1),
            ),
            height: 36,
            width: width * 0.65,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                const Icon(
                  Icons.health_and_safety,
                  color: AppColors.primary,
                  size: 20,
                ),
                Text(
                  'Trusted by 10k+ citizens',
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Hero Section & CTA button
        Column(
          spacing: 30.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text Column
            Column(
              spacing: 4.0,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      const TextSpan(text: 'Report Issues.\n'),
                      const TextSpan(text: 'Empower '),
                      TextSpan(
                        text: 'Communities.',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Join a modern network of citizens and local governments working together to maintain and improve civic infrastructure.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            // CTA buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                spacing: 16,
                children: [
                  AppButton(
                    text: 'Report Issue',
                    onPressed: () => context.go('/create-report'),
                    backgroundColor: AppColors.primary,
                    prefixIcon: const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 20,
                    ),
                  ),
                  AppButton(
                    text: 'Explore Issues',
                    onPressed: () => context.go('/explore-issues'),
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primary,
                    textColor: AppColors.primary,
                    prefixIcon: const Icon(Icons.search, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
