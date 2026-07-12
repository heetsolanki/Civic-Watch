import 'package:citizen/exports.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final IconData? icon;
  final Color? iconColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.confirmColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: AppColors.cardColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      alignment: Alignment.center,
      icon: icon != null
          ? CircleAvatar(
              radius: 30,
              backgroundColor: (iconColor ?? AppColors.primary).withValues(
                alpha: 0.1,
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 35,
              ),
            )
          : null,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        AppButton(
          onPressed: () => Navigator.pop(context, false),
          text: cancelText,
          borderColor: AppColors.primary.withValues(alpha: 0.2),
          backgroundColor: AppColors.cardColor,
          textColor: AppColors.textPrimary,
          width: width * 0.32,
          height: 45,
        ),
        AppButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm();
          },
          text: confirmText,
          backgroundColor: confirmColor ?? AppColors.primary,
          textColor: Colors.white,
          width: width * 0.32,
          height: 45,
        ),
      ],
    );
  }
}
