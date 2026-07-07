import 'package:citizen/exports.dart';

class ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final num value;
  final Color iconColor;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.5,
          color: AppColors.textPrimary.withOpacity(0.1),
        ),
      ),
      width: width * 0.27,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedFlipCounter(
            value: value,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            textStyle: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
