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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Confirm Location',
              subtitle:
                  'Verify the location of the issue on the map. You can drag the marker if needed.',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: MapContainer(
                draft: widget.draft,
                onLocationChanged: () => setState(() {}),
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
                        : 'Review Report',
                    suffixIcon: widget.mode == ReportFlowMode.create
                        ? const Icon(Icons.keyboard_arrow_right_rounded)
                        : null,
                    onPressed:
                        widget.draft.latitude != null &&
                            widget.draft.longitude != null
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
