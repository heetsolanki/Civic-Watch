import 'package:citizen/exports.dart';

class ReviewStep extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final ReportDraft draft;
  final ValueChanged<int> onEdit;

  const ReviewStep({
    super.key,
    required this.draft,
    required this.onBack,
    required this.title,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Review Your Report',
                    subtitle:
                        'Please verify the information below before submitting to local authorities.',
                  ),
                  const SizedBox(height: 8),
                  ReviewSectionCard(
                    title: 'Category',
                    onEdit: () => onEdit(0),
                    child: ReviewChip(label: draft.category ?? 'N/A'),
                  ),
                  const SizedBox(height: 20),
                  ReviewSectionCard(
                    title: 'Issue Photos',
                    onEdit: () => onEdit(1),
                    child: ReviewPhotosGallery(images: draft.images),
                  ),
                  const SizedBox(height: 20),
                  ReviewSectionCard(
                    title: 'Issue Details',
                    onEdit: () => onEdit(2),
                    child: ReviewDetailsContent(
                      category: draft.category ?? 'N/A',
                      title: draft.title,
                      description: draft.description,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReviewSectionCard(
                    title: 'Location',
                    onEdit: () => onEdit(3),
                    padding: EdgeInsets.zero,
                    child: ReviewLocationContent(
                      latitude: draft.latitude ?? 0,
                      longitude: draft.longitude ?? 0,
                      address: draft.address ?? 'No address found',
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          _buildStickyBottom(context),
        ],
      ),
    );
  }

  Widget _buildStickyBottom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ReviewStatusBanner(),
            const SizedBox(height: 20),
            AppButton(
              text: 'Submit Report',
              onPressed: () async {
                HapticFeedback.heavyImpact();
                // Show the blocking dialog
                showSubmittingReportDialog(context);

                // Simulate API call/upload
                await Future.delayed(const Duration(seconds: 2));

                if (context.mounted) {
                  // Dismiss the dialog
                  Navigator.pop(context);

                  // Navigate to success screen
                  context.go('/report-success');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
