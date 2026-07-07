import 'package:citizen/exports.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCard(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome to CivicWatch',
                      style: GoogleFonts.openSans(
                        fontSize: 22,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'By accessing or using this application, you agree to be bound by these terms. Please read them carefully.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            PolicySection(
              title: '1. Responsible Usage',
              children: [
                Text(
                  'CivicWatch is intended for genuine community improvement. Users must not submit false, misleading, offensive, or duplicate reports.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                const BulletItem(
                  text: 'Provide accurate and honest information',
                ),
                const BulletItem(
                  text: 'Upload only authentic photos of the issues',
                ),
                const BulletItem(text: 'Respect other users and the platform'),
                const BulletItem(text: 'Misuse may lead to account suspension'),
              ],
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
            PolicySection(
              title: '2. Prohibited Activities',
              children: [
                const BulletItem(text: 'Submitting fake or malicious reports'),
                const BulletItem(
                  text: 'Uploading copyrighted or inappropriate content',
                ),
                const BulletItem(text: 'Harassing other users or officials'),
                const BulletItem(
                  text: 'Attempting to exploit or disrupt the platform',
                ),
                const BulletItem(
                  text: 'Using the app for commercial advertising',
                ),
              ],
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            PolicySection(
              title: '3. Content Ownership',
              children: [
                Text(
                  'By submitting a report, you grant CivicWatch a non-exclusive, worldwide, royalty-free license to use, display, and share your submitted content for the purpose of issue resolution and platform improvement.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
            PolicySection(
              title: '4. Service Availability',
              children: [
                Text(
                  'While we strive to provide a reliable service, we do not guarantee that the application will always be available, uninterrupted, or error-free.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
            PolicySection(
              title: '5. Limitation of Liability',
              children: [
                Text(
                  'CivicWatch acts as a bridge between citizens and authorities. We do not guarantee that every reported issue will be resolved by the responsible government bodies.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
            PolicySection(
              title: '6. Account Termination',
              children: [
                Text(
                  'We reserve the right to suspend or terminate accounts that violate these terms or engage in activities harmful to the community.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Last updated: June 2024',
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ).animate().fadeIn(delay: 700.ms),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
