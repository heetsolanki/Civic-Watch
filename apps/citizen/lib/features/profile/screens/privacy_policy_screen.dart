import 'package:citizen/exports.dart';
import 'package:citizen/features/profile/widgets/bullet_item.dart';
import 'package:citizen/features/profile/widgets/info_card.dart';
import 'package:citizen/features/profile/widgets/policy_section.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Updated: July 2026',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'CivicWatch respects your privacy and is committed to protecting your personal information. This policy outlines how we handle your data.',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            PolicySection(
              title: '1. Information We Collect',
              children: [
                const BulletItem(text: 'Name and contact details'),
                const BulletItem(text: 'Email address and phone number'),
                const BulletItem(text: 'Profile photo (optional)'),
                const BulletItem(
                  text: 'Precise location (only when reporting issues)',
                ),
                const BulletItem(text: 'Images uploaded with reports'),
                const BulletItem(
                  text: 'Device information and app usage analytics',
                ),
              ],
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
            PolicySection(
              title: '2. How We Use Your Information',
              children: [
                const BulletItem(
                  text: 'To create and manage your secure account',
                ),
                const BulletItem(
                  text: 'To process and submit your civic issue reports',
                ),
                const BulletItem(
                  text:
                      'To display your submitted reports to relevant authorities',
                ),
                const BulletItem(
                  text: 'To notify you about report status updates',
                ),
                const BulletItem(
                  text: 'To improve app performance and user experience',
                ),
                const BulletItem(
                  text: 'To prevent fraud and maintain platform integrity',
                ),
              ],
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            PolicySection(
              title: '3. Location Data',
              children: [
                Text(
                  'Location data is essential for accurately mapping civic issues. We collect your coordinates only when you are actively creating a report or have explicitly granted permission.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'You can manage or disable location permissions at any time through your device settings.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
            PolicySection(
              title: '4. Data Security',
              children: [
                Text(
                  'We implement industry-standard security measures to safeguard your personal information from unauthorized access, alteration, or disclosure. However, no method of transmission over the internet is 100% secure.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
            PolicySection(
              title: '5. Third-Party Services',
              children: [
                const BulletItem(text: 'Authentication & Identity providers'),
                const BulletItem(text: 'Secure cloud storage solutions'),
                const BulletItem(
                  text: 'App performance and analytics services',
                ),
                const BulletItem(text: 'Mapping and geospatial services'),
                const BulletItem(text: 'Push notification services'),
                const SizedBox(height: 8),
                Text(
                  'These providers only receive the minimal data required to perform their specific functions on our behalf.',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
            PolicySection(
              title: '6. Your Rights',
              children: [
                const BulletItem(
                  text: 'Access and update your profile information',
                ),
                const BulletItem(text: 'Request a copy of your personal data'),
                const BulletItem(
                  text: 'Request deletion of your account and associated data',
                ),
                const BulletItem(
                  text: 'Opt-out of non-essential communications',
                ),
              ],
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '© 2024 CivicWatch. All rights reserved.',
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
