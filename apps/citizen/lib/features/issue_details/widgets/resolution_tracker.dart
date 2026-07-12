import 'package:citizen/exports.dart';

class ResolutionTracker extends StatelessWidget {
  final Report report;

  const ResolutionTracker({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    const statuses = ['pending', 'in_progress', 'resolved'];
    const statusLabels = ['Reported', 'Processing', 'Resolved'];
    final currentStatusIndex = statuses.indexOf(report.status.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Resolution Tracker'),
        InfoCard(
          child: Column(
            children: List.generate(statuses.length, (index) {
              final isCompleted = index <= currentStatusIndex;
              final isLast = index == statuses.length - 1;

              String subtitle;
              if (isCompleted) {
                if (index == 0) {
                  subtitle =
                      '${AppDateFormatter.formatShort(report.createdAt)} • ${report.userId}';
                } else if (index == 1) {
                  subtitle = AppDateFormatter.formatShort(report.updatedAt);
                } else {
                  subtitle = AppDateFormatter.formatShort(report.updatedAt);
                }
              } else {
                subtitle = index == 1
                    ? 'Pending Assignment'
                    : 'Pending Completion';
              }

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppColors.success
                                : Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCompleted
                                ? Icons.check_rounded
                                : _getIconForIndex(index),
                            size: 16,
                            color: isCompleted
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: isCompleted
                                  ? AppColors.success.withValues(alpha: 0.3)
                                  : Colors.grey.shade200,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusLabels[index],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isCompleted
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isCompleted
                                  ? AppColors.textSecondary
                                  : Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.report_problem_rounded;
      case 1:
        return Icons.verified_user_rounded;
      case 2:
        return Icons.task_alt_rounded;
      default:
        return Icons.circle;
    }
  }
}
