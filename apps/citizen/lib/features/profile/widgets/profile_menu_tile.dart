import 'package:citizen/exports.dart';

class ProfileMenuTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final bool trailingIcon;
  final Color labelColor;
  final Widget? trailing;

  const ProfileMenuTile({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.primary,
    this.labelColor = Colors.black,
    this.trailingIcon = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.25),
          child: Icon(icon, size: 23, color: iconColor),
        ),
        title: Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 16,
            color: labelColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing:
            trailing ??
            (trailingIcon
                ? Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 28,
                    color: AppColors.textPrimary,
                  )
                : null),
        selectedTileColor: AppColors.primary.withOpacity(0.5),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
      ),
    );
  }
}
