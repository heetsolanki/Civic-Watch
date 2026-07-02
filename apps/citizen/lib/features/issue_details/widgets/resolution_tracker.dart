import 'package:citizen/exports.dart';

class ResolutionTracker extends StatefulWidget {
  final IssueData issue;

  const ResolutionTracker({super.key, required this.issue});

  @override
  State<ResolutionTracker> createState() => _ResolutionTrackerState();
}

class _ResolutionTrackerState extends State<ResolutionTracker> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final statuses = ['Reported', 'Verified', 'Assigned', 'Resolved'];

    final currentStatusIndex = statuses.indexOf(widget.issue.status);

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Resolution Tracker',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      VerticalDivider(
                        width: 40,
                        thickness: 2,
                        color: Colors.grey[300],
                      ),
                      Column(
                        spacing: 50,
                        children: List.generate(statuses.length, (index) {
                          final isCompleted = index <= currentStatusIndex;
                          IconData icon;
                          if (index == 0 || index == 1) {
                            icon = Icons.check;
                          } else if (index == 2) {
                            icon = Icons.person;
                          } else {
                            icon = Icons.verified;
                          }

                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: isCompleted
                                ? AppColors.smallText
                                : Colors.grey[400],
                            child: Icon(
                              isCompleted ? Icons.check : icon,
                              color: AppColors.cardColor,
                              size: 20,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      spacing: 48,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(statuses.length, (index) {
                        final isCompleted = index <= currentStatusIndex;
                        String subtitle;
                        if (isCompleted) {
                          // Mock dates for completed steps
                          if (index == 0) {
                            subtitle =
                                '${widget.issue.reportedOn} by ${widget.issue.userId}';
                          } else if (index == 1) {
                            subtitle = widget.issue.verifiedOn;
                          } else if (index == 2) {
                            subtitle = widget.issue.assignedOn;
                          } else if (index == 3) {
                            subtitle = widget.issue.resolvedOn;
                          } else {
                            subtitle = 'Completed';
                          }
                        } else {
                          subtitle = index == 2
                              ? 'Pending Assignment'
                              : 'Pending Completion';
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              statuses[index],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isCompleted
                                    ? AppColors.textPrimary
                                    : Colors.grey[600],
                              ),
                            ),
                            Text(
                              subtitle,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isCompleted
                                    ? Colors.black
                                    : Colors.grey[500],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
