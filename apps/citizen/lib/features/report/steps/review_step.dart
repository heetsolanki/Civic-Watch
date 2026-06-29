import 'package:citizen/exports.dart';

class ReviewStep extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final ReportDraft draft;
  final Function(int) onEdit;

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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
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
                    padding: const EdgeInsets.all(0),
                    child: ReviewLocationContent(
                      latitude: draft.latitude ?? 0,
                      longitude: draft.longitude ?? 0,
                      address: draft.address ?? 'No address found',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildStickyBottom(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Center(
          child: Text(
            'Review your report',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Please verify the information below before submitting.',
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildStickyBottom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
              onPressed: () {
                AppToast.success(context, 'Report submitted successfully!');
                context.go('/main');
              },
            ),
          ],
        ),
      ),
    );
  }
}
