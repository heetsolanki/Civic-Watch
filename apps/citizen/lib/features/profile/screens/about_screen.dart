import 'package:citizen/exports.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About CivicWatch',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo & App Name
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'CivicWatch',
                    style: GoogleFonts.openSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 40),

            // Mission & Vision
            const SectionHeader(
              title: 'Our Purpose',
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubSection(
                    title: 'Mission',
                    content:
                        'To empower citizens with a simple digital tool to report civic issues and facilitate faster resolution through transparency and community participation.',
                    icon: Icons.rocket_launch_outlined,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1, thickness: 0.5),
                  ),
                  _buildSubSection(
                    title: 'Vision',
                    content:
                        'Creating cleaner, safer, and better-managed communities by bridging the gap between citizens and local authorities.',
                    icon: Icons.visibility_outlined,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),

            // Key Features
            const SectionHeader(
              title: 'Key Features',
              subtitle: 'Everything you need to make your voice heard.',
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            const Column(
              children: [
                BulletItem(
                  text: 'One-tap civic issue reporting with photo uploads',
                ),
                BulletItem(
                  text: 'Automatic location detection for precise mapping',
                ),
                BulletItem(text: 'Real-time status tracking of your reports'),
                BulletItem(text: 'Secure user profiles and report history'),
                BulletItem(text: 'Community-driven feedback and moderation'),
              ],
            ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),

            // Roadmap
            const SectionHeader(
              title: 'Future Roadmap',
              subtitle: 'Coming soon to CivicWatch.',
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
            InfoCard(
              color: AppColors.primary.withOpacity(0.02),
              child: const Column(
                children: [
                  BulletItem(text: 'Direct communication with local officials'),
                  BulletItem(
                    text: 'AI-based issue categorization and severity analysis',
                  ),
                  BulletItem(text: 'Neighborhood leaderboards and rewards'),
                  BulletItem(
                    text: 'Multi-language support for better accessibility',
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.1),
            const SizedBox(height: 40),

            // About Developer
            const SectionHeader(
              title: 'About the Developer',
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Heet Solanki',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Full Stack Flutter Developer',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Passionate about building software that solves real-world problems. CivicWatch is a step towards digitizing civic engagement.',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Technology Stack',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: const [
                      TechPill(text: 'Flutter'),
                      TechPill(text: 'Dart'),
                      TechPill(text: 'Firebase'),
                      TechPill(text: 'Node.js'),
                      TechPill(text: 'Express.js'),
                      TechPill(text: 'PostgreSQL'),
                      TechPill(text: 'Prisma'),
                      TechPill(text: 'Riverpod'),
                      TechPill(text: 'REST API'),
                      TechPill(text: 'Git'),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.1),
            const SizedBox(height: 48),

            // Footer
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
                  const Text(
                    'Made with ❤️ in India',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSubSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
