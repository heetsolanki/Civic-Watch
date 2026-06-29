import 'package:citizen/exports.dart';

class ReviewDetailsContent extends StatelessWidget {
  final String category;
  final String title;
  final String description;

  const ReviewDetailsContent({
    super.key,
    required this.category,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewChip(label: category),
        const SizedBox(height: 16),
        Text(
          'Title',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Description',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: AppColors.textPrimary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
