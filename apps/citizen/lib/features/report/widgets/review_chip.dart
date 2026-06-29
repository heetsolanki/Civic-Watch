import 'package:citizen/exports.dart';

class ReviewChip extends StatelessWidget {
  final String label;
  final bool isSecondary;

  const ReviewChip({
    super.key,
    required this.label,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSecondary
            ? AppColors.textPrimary.withValues(alpha: 0.05)
            : AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSecondary
              ? AppColors.textPrimary.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSecondary ? AppColors.textPrimary : AppColors.primary,
        ),
      ),
    );
  }
}
