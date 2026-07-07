import 'package:citizen/exports.dart';

class CategoryStatusPill extends StatelessWidget {
  final IssueData issue;

  const CategoryStatusPill({super.key, required this.issue});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Reported':
        return Colors.orange;
      case 'Verified':
        return Colors.blue;
      case 'Assigned':
        return Colors.deepPurple;
      case 'Resolved':
        return AppColors.success;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(issue.status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(issue.icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                issue.category,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: statusColor,
                ),
                height: 8,
                width: 8,
              ),
              const SizedBox(width: 8),
              Text(
                issue.status,
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
