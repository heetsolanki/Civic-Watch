import 'package:citizen/exports.dart';

class InfoContainer extends StatelessWidget {
  final Report report;

  const InfoContainer({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          report.title,
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
                report.address,
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
          report.description,
          style: GoogleFonts.openSans(
            fontSize: 15,
            height: 1.6,
            color: AppColors.textPrimary.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
