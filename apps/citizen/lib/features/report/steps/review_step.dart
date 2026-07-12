import 'package:citizen/exports.dart';
import '../services/report_dialog_service.dart';

class ReviewStep extends StatefulWidget {
  final String title;
  final VoidCallback onBack;
  final Report draft;
  final ValueChanged<int> onEdit;

  const ReviewStep({
    super.key,
    required this.draft,
    required this.onBack,
    required this.title,
    required this.onEdit,
  });

  @override
  State<ReviewStep> createState() => _ReviewStepState();
}

class _ReviewStepState extends State<ReviewStep> {
  bool _isSubmitting = false;

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
                    onEdit: () => widget.onEdit(0),
                    child: ReviewChip(
                      label: widget.draft.category.isNotEmpty
                          ? widget.draft.category
                          : 'N/A',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReviewSectionCard(
                    title: 'Issue Photos',
                    onEdit: () => widget.onEdit(1),
                    child: ReviewPhotosGallery(images: widget.draft.images),
                  ),
                  const SizedBox(height: 20),
                  ReviewSectionCard(
                    title: 'Issue Details',
                    onEdit: () => widget.onEdit(2),
                    child: ReviewDetailsContent(
                      category: widget.draft.category.isNotEmpty
                          ? widget.draft.category
                          : 'N/A',
                      title: widget.draft.title,
                      description: widget.draft.description,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReviewSectionCard(
                    title: 'Location',
                    onEdit: () => widget.onEdit(3),
                    padding: EdgeInsets.zero,
                    child: ReviewLocationContent(
                      latitude: widget.draft.latitude,
                      longitude: widget.draft.longitude,
                      address: widget.draft.address.isNotEmpty
                          ? widget.draft.address
                          : 'No address found',
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
              isLoading: _isSubmitting,
              onPressed: _isSubmitting
                  ? null
                  : () async {
                      try {
                        setState(() => _isSubmitting = true);
                        HapticFeedback.heavyImpact();

                        final report = widget.draft.copyWith(
                          status: ReportStatus.pending,
                          updatedAt: DateTime.now(),
                        );

                        // 1. Save to reports box
                        await context.read<ReportsProvider>().addReport(report);

                        // 2. Remove from drafts box
                        await context.read<DraftProvider>().deleteDraft(
                          report.id,
                        );

                        if (mounted) {
                          await ReportDialogHelper.showSubmittingExperience(
                            context,
                            () {
                              if (mounted) context.go('/report-success');
                            },
                          );
                        }
                      } catch (e, stackTrace) {
                        debugPrintStack(stackTrace: stackTrace);
                        if (mounted) {
                          setState(() => _isSubmitting = false);
                          AppToast.error(
                            context,
                            'Failed to submit report. Please try again.',
                          );
                        }
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
