import 'package:citizen/exports.dart';
import 'package:citizen/core/services/image_service.dart';

class PhotoStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Report draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;
  final ValueChanged<Report> onUpdate;

  const PhotoStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
    required this.onUpdate,
  });

  @override
  State<PhotoStep> createState() => _PhotoStepState();
}

class _PhotoStepState extends State<PhotoStep> {
  static const int _maxImages = 5;

  Future<void> _handleCamera() async {
    if (widget.draft.images.length >= _maxImages) {
      AppToast.error(context, 'Maximum of $_maxImages photos allowed');
      return;
    }

    final processed = await ImageService.pickAndProcessImage(
      source: ImageSource.camera,
    );

    if (processed != null) {
      HapticFeedback.lightImpact();
      widget.onUpdate(widget.draft.copyWith(
        images: [...widget.draft.images, processed.path],
      ));
    }
  }

  Future<void> _handleGallery() async {
    final remaining = _maxImages - widget.draft.images.length;
    if (remaining <= 0) {
      AppToast.error(context, 'Maximum of $_maxImages photos allowed');
      return;
    }

    final List<File> processedImages =
        await ImageService.pickAndProcessMultiImage(maxImages: remaining);

    if (processedImages.isNotEmpty) {
      HapticFeedback.lightImpact();
      widget.onUpdate(widget.draft.copyWith(
        images: [
          ...widget.draft.images,
          ...processedImages.map((f) => f.path),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Photo Evidence',
              subtitle:
                  'Help us understand the issue better by attaching up to 5 clear photos.',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    DraftImageContainer(
                      report: widget.draft,
                      onRemove: (index) {
                        final newImages = List<String>.from(widget.draft.images)
                          ..removeAt(index);
                        widget.onUpdate(widget.draft.copyWith(images: newImages));
                      },
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Capture a photo',
                      prefixIcon: const Icon(
                        Icons.camera_alt_rounded,
                        size: 20,
                      ),
                      onPressed: _handleCamera,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      backgroundColor: Colors.white,
                      borderColor: AppColors.primary.withValues(alpha: 0.2),
                      textColor: AppColors.primary,
                      text: 'Upload from gallery',
                      prefixIcon: const Icon(
                        Icons.photo_library_rounded,
                        size: 20,
                      ),
                      onPressed: _handleGallery,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (widget.mode == ReportFlowMode.create) ...[
                  Expanded(
                    child: AppButton(
                      text: 'Back',
                      prefixIcon: const Icon(Icons.keyboard_arrow_left_rounded),
                      backgroundColor: Colors.white,
                      borderColor: AppColors.primary.withValues(alpha: 0.2),
                      textColor: AppColors.primary,
                      onPressed: widget.onBack,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  flex: 2,
                  child: AppButton(
                    text: widget.mode == ReportFlowMode.edit
                        ? 'Save Changes'
                        : 'Continue',
                    suffixIcon: widget.mode == ReportFlowMode.create
                        ? const Icon(Icons.keyboard_arrow_right_rounded)
                        : null,
                    onPressed: widget.draft.images.isNotEmpty
                        ? (widget.mode == ReportFlowMode.edit
                              ? widget.onSave
                              : widget.onNext)
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
