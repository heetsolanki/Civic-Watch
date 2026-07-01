import 'package:citizen/exports.dart';

class InfoContainer extends StatelessWidget {
  final IssueData issue;
  const InfoContainer({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          issue.title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        // Location
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey[600],
              size: 20,
            ),
            Text(
              issue.location,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        // Description
        Text(issue.description, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    );
  }
}
