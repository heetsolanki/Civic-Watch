import 'package:citizen/exports.dart';

class ReportStatus {
  static const String draft = 'draft';
  static const String pending = 'pending';
  static const String inProgress = 'in_progress';
  static const String resolved = 'resolved';
  static const String rejected = 'rejected';

  const ReportStatus._();

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case draft:
        return Colors.grey;
      case pending:
        return Colors.orange.shade500;
      case inProgress:
        return Colors.blue.shade500;
      case resolved:
        return AppColors.success;
      case rejected:
        return Colors.red.shade500;
      default:
        return Colors.grey;
    }
  }

  static String getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case draft:
        return 'Draft';
      case pending:
        return 'Reported';
      case inProgress:
        return 'Processing';
      case resolved:
        return 'Resolved';
      case rejected:
        return 'Rejected';
      default:
        return status;
    }
  }
}
