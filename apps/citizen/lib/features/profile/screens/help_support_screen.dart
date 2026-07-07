import 'package:citizen/exports.dart';
import 'package:citizen/features/profile/data/faq_data.dart';
import 'package:citizen/features/profile/functions/launch_functions.dart';
import 'package:citizen/features/profile/widgets/section_header.dart';
import 'package:citizen/features/profile/widgets/info_card.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _expandedIndex;

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
          'Help & Support',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Frequently Asked Questions',
              subtitle:
                  'Find quick answers to common questions about using CivicWatch and reporting issues.',
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            ...faqDataList.asMap().entries.map((entry) {
              final index = entry.key;
              final faq = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:
                    CustomExpansionTile(
                          title: faq.title,
                          content: faq.content,
                          isExpanded: _expandedIndex == index,
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _expandedIndex = expanded ? index : null;
                            });
                          },
                        )
                        .animate()
                        .fadeIn(delay: (100 + index * 50).ms)
                        .slideY(begin: 0.1),
              );
            }),
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Contact Support',
              subtitle:
                  'Can\'t find what you\'re looking for? Reach out to our team directly.',
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
            InfoCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildContactTile(
                    icon: Icons.email_outlined,
                    title: 'Email Us',
                    subtitle: 'solankiheet456@gmail.com',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      LaunchFunctions.launchEmail('solankiheet456@gmail.com');
                    },
                  ),
                  Divider(
                    height: 1,
                    indent: 72,
                    endIndent: 20,
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  _buildContactTile(
                    icon: Icons.phone_outlined,
                    title: 'Call Us',
                    subtitle: '+91 77382 50800',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      LaunchFunctions.launchPhone('+917738250800');
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
            const SizedBox(height: 48),
            Center(
              child: Column(
                children: [
                  Text(
                    'CivicWatch v1.0.0',
                    style: GoogleFonts.openSans(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Made with ❤️ in India',
                    style: GoogleFonts.openSans(
                      color: AppColors.textSecondary.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.openSans(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppColors.textSecondary.withOpacity(0.5),
      ),
      onTap: onTap,
    );
  }
}
