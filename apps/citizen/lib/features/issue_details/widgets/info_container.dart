import 'package:citizen/exports.dart';

class InfoContainer extends StatelessWidget {
  final IssueData issue;

  const InfoContainer({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          issue.title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        // Location
        Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              color: AppColors.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                issue.location,
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          issue.description,
          style: GoogleFonts.openSans(
            fontSize: 15,
            height: 1.6,
            color: AppColors.textPrimary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
