import 'package:citizen/exports.dart';

class DetailsStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final ReportDraft draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;

  const DetailsStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
  });

  @override
  State<DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<DetailsStep> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    bool isStepValid = widget.draft.title.length >= 10 &&
        widget.draft.title.length <= 100 &&
        widget.draft.description.length >= 20 &&
        widget.draft.description.length <= 500;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Issue Details',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Provide a clear title and description for the issue.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Title Field
              TitleField(
                category: widget.draft.category!,
                value: widget.draft.title,
                onChanged: (value) {
                  setState(() {
                    widget.draft.title = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // Description Field
              DescriptionField(
                value: widget.draft.description,
                onChanged: (value) {
                  setState(() {
                    widget.draft.description = value;
                  });
                },
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.mode == ReportFlowMode.create)
                    AppButton(
                      width: width * 0.4,
                      text: 'Back',
                      prefixIcon: const Icon(Icons.keyboard_arrow_left),
                      backgroundColor: Colors.white,
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
                        onPressed: isStepValid
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
      ),
    );
  }
}
