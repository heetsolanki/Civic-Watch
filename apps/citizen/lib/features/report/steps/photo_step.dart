import 'package:citizen/exports.dart';
import 'package:citizen/core/services/image_service.dart';
import 'package:citizen/features/report/widgets/image_container.dart';

class PhotoStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final ReportDraft draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;

  const PhotoStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
  });

  @override
  State<PhotoStep> createState() => _PhotoStepState();
}

class _PhotoStepState extends State<PhotoStep> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Photo Evidence',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Help us understand the issue better by attaching up to 5 clear photos.',
              style: GoogleFonts.openSans(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            ImageContainer(draft: widget.draft),
            AppButton(
              width: width * 0.65,
              text: 'Capture a photo',
              prefixIcon: const Icon(Icons.camera_alt, size: 20),
              onPressed: () async {
                if (widget.draft.images.length >= 5) {
                  AppToast.error(context, 'Maximum of 5 photos allowed');
                  return;
                }

                final processed = await ImageService.pickAndProcessImage(
                  source: ImageSource.camera,
                );

                if (processed != null) {
                  setState(() {
                    widget.draft.images.add(processed);
                  });
                }
              },
            ),
            Text(
              'OR',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            AppButton(
              width: width * 0.65,
              backgroundColor: AppColors.cardColor,
              borderColor: AppColors.primary,
              textColor: AppColors.primary,
              text: 'Upload from gallery',
              prefixIcon: const Icon(Icons.photo_library, size: 20),
              onPressed: () async {
                final remaining = 5 - widget.draft.images.length;
                if (remaining <= 0) {
                  AppToast.error(context, 'Maximum of 5 photos allowed');
                  return;
                }

                final List<File> processedImages =
                    await ImageService.pickAndProcessMultiImage(
                      maxImages: remaining,
                    );

                if (processedImages.isNotEmpty) {
                  setState(() {
                    widget.draft.images.addAll(processedImages);
                  });
                }
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.mode == ReportFlowMode.create)
                  AppButton(
                    width: width * 0.4,
                    text: 'Back',
                    prefixIcon: const Icon(Icons.keyboard_arrow_left),
                    backgroundColor: AppColors.cardColor,
                    borderColor: AppColors.primary,
                    textColor: AppColors.primary,
                    onPressed: widget.onBack,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: widget.mode == ReportFlowMode.create ? 15 : 0,
                    ),
                    child: AppButton(
                      text: widget.mode == ReportFlowMode.edit
                          ? 'Save Changes'
                          : 'Continue',
                      suffixIcon: widget.mode == ReportFlowMode.create
                          ? const Icon(Icons.keyboard_arrow_right)
                          : null,
                      onPressed: widget.draft.images.isNotEmpty
                          ? (widget.mode == ReportFlowMode.edit
                                ? widget.onSave
                                : widget.onNext)
                          : null,
                    ),
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
