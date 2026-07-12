import 'package:citizen/exports.dart';

class DetailsStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Report draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;
  final ValueChanged<Report> onUpdate;

  const DetailsStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
    required this.onUpdate,
  });

  @override
  State<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<DetailsStep> {
  bool get _isStepValid =>
      widget.draft.title.trim().length >= 10 &&
      widget.draft.title.trim().length <= 100 &&
      widget.draft.description.trim().length >= 20 &&
      widget.draft.description.trim().length <= 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Issue Details',
              subtitle:
                  'Provide a clear title and description to help authorities understand the issue.',
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Title Field
                    TitleField(
                      category: widget.draft.category.isNotEmpty ? widget.draft.category : 'Other',
                      value: widget.draft.title,
                      onChanged: (value) =>
                          widget.onUpdate(widget.draft.copyWith(title: value)),
                    ),
                    const SizedBox(height: 32),
                    // Description Field
                    DescriptionField(
                      value: widget.draft.description,
                      onChanged: (value) =>
                          widget.onUpdate(widget.draft.copyWith(description: value)),
                    ),
                    const SizedBox(height: 32),
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
                      borderColor: AppColors.primary.withOpacity(0.2),
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
                    onPressed: _isStepValid
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
