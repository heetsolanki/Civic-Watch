import 'package:citizen/exports.dart';

class ReviewChip extends StatelessWidget {
  final String label;
  final bool isSecondary;

  const ReviewChip({super.key, required this.label, this.isSecondary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSecondary
            ? AppColors.textPrimary.withOpacity(0.05)
            : AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSecondary
              ? AppColors.textPrimary.withOpacity(0.1)
              : AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.openSans(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: isSecondary ? AppColors.textPrimary : AppColors.primary,
        ),
      ),
    );
  }
}
