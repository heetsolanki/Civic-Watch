import 'package:citizen/exports.dart';

class ProfileSection extends StatelessWidget {
  final VoidCallback loadUser;

  const ProfileSection({super.key, required this.loadUser});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Account'),
        InfoCard(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            width: width * 0.85,
            child: Column(
              children: [
                ProfileMenuTile(
                  label: 'Edit Profile',
                  icon: Icons.person_rounded,
                  onTap: () async {
                    final updated = await context.push<bool>('/edit-profile');
                    if (updated == true) {
                      loadUser();
                    }
                  },
                ),
                const Divider(indent: 70, endIndent: 20, thickness: 0.5),
                ProfileMenuTile(
                  label: 'Preferences',
                  icon: Icons.notifications_rounded,
                  onTap: () => context.push('/preferences'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Support'),
        InfoCard(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            width: width * 0.85,
            child: Column(
              children: [
                ProfileMenuTile(
                  label: 'Help & Support',
                  icon: Icons.help_rounded,
                  onTap: () => context.push('/help-support'),
                ),
                const Divider(indent: 70, endIndent: 20, thickness: 0.5),
                ProfileMenuTile(
                  label: 'Privacy Policy',
                  icon: Icons.privacy_tip_rounded,
                  onTap: () => context.push('/privacy-policy'),
                ),
                const Divider(indent: 70, endIndent: 20, thickness: 0.5),
                ProfileMenuTile(
                  label: 'Terms & Conditions',
                  icon: Icons.description_rounded,
                  onTap: () => context.push('/terms'),
                ),
                const Divider(indent: 70, endIndent: 20, thickness: 0.5),
                ProfileMenuTile(
                  label: 'About CivicWatch',
                  icon: Icons.info_rounded,
                  onTap: () => context.push('/about'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Security'),
        InfoCard(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            width: width * 0.85,
            child: Column(
              children: [
                ProfileMenuTile(
                  label: 'Logout',
                  labelColor: AppColors.danger,
                  icon: Icons.logout_rounded,
                  iconColor: AppColors.danger,
                  trailingIcon: false,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    auth.logout();
                    context.go('/auth');
                    AppToast.error(context, 'You have been logged out.');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
