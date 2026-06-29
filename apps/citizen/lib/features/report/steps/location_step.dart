import 'package:citizen/exports.dart';

class LocationStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final ReportDraft draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;

  const LocationStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
  });

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Where is the issue?',
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
                'Confirm the location of the issue.',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            MapContainer(
              draft: widget.draft,
              onLocationChanged: () => setState(() {}),
            ),
            const Spacer(),
            // buttons
            Row(
              children: [
                if (widget.mode == ReportFlowMode.create)
                  Expanded(
                    child: AppButton(
                      width: width * 0.4,
                      text: 'Back',
                      prefixIcon: const Icon(Icons.keyboard_arrow_left),
                      backgroundColor: Colors.white,
                      borderColor: AppColors.primary,
                      textColor: AppColors.primary,
                      onPressed: widget.onBack,
                    ),
                  ),
                if (widget.mode == ReportFlowMode.create)
                  const SizedBox(width: 15),
                Expanded(
                  child: AppButton(
                    width: width * 0.4,
                    text: widget.mode == ReportFlowMode.edit 
                        ? 'Save Changes' 
                        : 'Review Report',
                    suffixIcon: widget.mode == ReportFlowMode.create 
                        ? const Icon(Icons.keyboard_arrow_right)
                        : null,
                    onPressed:
                        widget.draft.latitude != null &&
                            widget.draft.longitude != null
                        ? (widget.mode == ReportFlowMode.edit ? widget.onSave : widget.onNext)
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
