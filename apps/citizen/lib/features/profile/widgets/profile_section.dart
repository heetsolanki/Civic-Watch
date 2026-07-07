import 'package:citizen/exports.dart';

class ProfileSection extends StatelessWidget {
  final VoidCallback loadUser;

  const ProfileSection({super.key, required this.loadUser});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          width: width * 0.85,
          child: Column(
            children: [
              ProfileMenuTile(
                label: 'Edit Profile',
                icon: Icons.person,
                onTap: () async {
                  final updated = await context.push<bool>('/edit-profile');
                  if (updated == true) {
                    loadUser();
                  }
                },
              ),
              Divider(indent: 50, endIndent: 50, thickness: 0.75, height: 20),
              ProfileMenuTile(
                label: 'Preferences',
                icon: Icons.notifications,
                onTap: () => context.push('/preferences'),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Support',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          width: width * 0.85,
          child: Column(
            children: [
              ProfileMenuTile(
                label: 'Help & Support',
                icon: Icons.help,
                onTap: () => context.push('/help-support'),
              ),
              Divider(indent: 50, endIndent: 50, thickness: 0.75, height: 20),
              ProfileMenuTile(
                label: 'Privacy Policy',
                icon: Icons.privacy_tip,
                onTap: () => context.push('/privacy-policy'),
              ),
              Divider(indent: 50, endIndent: 50, thickness: 0.75, height: 20),
              ProfileMenuTile(
                label: 'Terms & Conditions',
                icon: Icons.description,
                onTap: () => context.push('/terms'),
              ),
              Divider(indent: 50, endIndent: 50, thickness: 0.75, height: 20),
              ProfileMenuTile(
                label: 'About CivicWatch',
                icon: Icons.info,
                onTap: () => context.push('/about'),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Security',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          width: width * 0.85,
          child: Column(
            children: [
              ProfileMenuTile(
                label: 'Logout',
                labelColor: Colors.red,
                icon: Icons.logout,
                iconColor: Colors.red,
                trailingIcon: false,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  auth.logout();
                  AppToast.error(context, 'You have been logged out.');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
