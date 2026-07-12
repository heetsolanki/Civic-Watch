import 'package:citizen/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String username = '';
  String phone = '';
  String email = '';
  int civicPoints = 0;
  String? imagePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    if (!mounted) return;
    setState(() => isLoading = true);
    final data = await AppPreferences.getUser();
    if (!mounted) return;
    setState(() {
      name = data['name'] ?? '';
      username = data['username'] ?? '';
      phone = data['phone'] ?? '';
      email = data['email'] ?? '';
      civicPoints = data['civicPoints'] ?? 0;
      imagePath = data['imagePath'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeletonizer(
        enabled: isLoading,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ProfileHeader(
                    name: name,
                    username: username,
                    email: email,
                    phone: phone,
                    civicPoints: civicPoints,
                    imagePath: imagePath,
                  ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1),
                  const SizedBox(height: 25),
                  _ImpactSection(isLoading: isLoading),
                  const SizedBox(height: 25),
                  ProfileSection(
                    loadUser: loadUser,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                  const SizedBox(height: 40),
                  const _ProfileFooter(),
                  const SizedBox(height: 110),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactSection extends StatelessWidget {
  final bool isLoading;

  const _ImpactSection({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Civic Impact',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileStatCard(
              icon: Icons.receipt,
              label: 'Reports',
              value: isLoading ? 0 : 12,
              iconColor: AppColors.primary,
            ),
            ProfileStatCard(
              icon: Icons.check_circle_outline_outlined,
              label: 'Resolved',
              value: isLoading ? 0 : 8,
              iconColor: AppColors.success,
            ),
            ProfileStatCard(
              icon: Icons.thumb_up,
              label: 'Supported',
              value: isLoading ? 0 : 25,
              iconColor: AppColors.warning,
            ),
          ],
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
      ],
    );
  }
}

class _ProfileFooter extends StatelessWidget {
  const _ProfileFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Made with ❤️ for better communities',
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'v1.0.0',
          style: GoogleFonts.openSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }
}
