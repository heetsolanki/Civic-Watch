import 'package:citizen/core/widgets/get_category_icon.dart';
import 'package:citizen/exports.dart';
import 'package:intl/intl.dart';

class IssueCard extends StatelessWidget {
  final Report report;

  const IssueCard({super.key, required this.report});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Reported':
        return Colors.orange.shade500;
      case 'Verified':
        return Colors.blue.shade500;
      case 'Assigned':
        return Colors.deepPurple.shade500;
      case 'Resolved':
        return AppColors.success;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pillColor = _getStatusColor(report.status);
    final width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/view-details/${report.id}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cardColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 10,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        padding: const EdgeInsets.only(bottom: 10),
        width: width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: report.images.isEmpty
                  ? _buildPlaceholder()
                  : _buildImage(report.images.first),
            ),
            // Main Content Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon + Text Row
                      Row(
                        spacing: 6,
                        children: [
                          Icon(
                            getCategoryIcon(report.category),
                            size: 18,
                            color: AppColors.primary,
                          ),
                          Text(
                            report.category,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Pill Container
                      Container(
                        decoration: BoxDecoration(
                          color: pillColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
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
                              height: 8,
                              width: 8,
                            ),
                            Text(
                              report.status,
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: pillColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Title
                  Text(
                    report.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  // Location & Date Section
                  Column(
                    spacing: 8,
                    children: [
                      _buildInfoRow(Icons.location_on, report.address),
                      _buildInfoRow(
                        Icons.date_range,
                        DateFormat('dd-MM-yyyy').format(report.createdAt),
                      ),
                    ],
                  ),
                  const Divider(height: 8),
                  Row(
                    spacing: 8,
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      Text(
                        '0 Supporters',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
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
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        height: 180,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        height: 180,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Colors.grey.shade400,
          size: 48,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      spacing: 6,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
