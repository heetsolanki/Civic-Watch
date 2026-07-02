import 'package:citizen/exports.dart';

class IssueCard extends StatelessWidget {
  final IssueData issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    late Color pillColor;
    double width = MediaQuery.of(context).size.width;

    if (issue.status == 'Reported') {
      pillColor = Colors.orange.shade500;
    } else if (issue.status == 'Verified') {
      pillColor = Colors.blue.shade500;
    } else if (issue.status == 'Assigned') {
      pillColor = Colors.deepPurple.shade500;
    } else if (issue.status == 'Resolved') {
      pillColor = AppColors.smallText;
    }
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cardColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 0.9,
              spreadRadius: 0.8,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        padding: EdgeInsets.only(bottom: 10),
        width: width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(issue.coverImage),
            ),
            // Main Content Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon + Text Row
                      Row(
                        spacing: 5,
                        children: [
                          Icon(
                            issue.icon,
                            size: 18,
                            color: AppColors.smallText,
                          ),
                          Text(
                            issue.category,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.smallText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Pill Container
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 6,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: pillColor,
                              ),
                              height: 7,
                              width: 7,
                            ),
                            Text(
                              issue.status,
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Title
                  Text(
                    issue.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Location (Icon + Text)
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      Text(
                        issue.location,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  // Report Date
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      Text(
                        issue.reportedOn,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 20,
                        color: AppColors.textPrimary,
                      ),
                      Text(
                        '${issue.supportedCount} Supporters',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        context.go('/view-details/${issue.id}');
      },
    );
  }
}
