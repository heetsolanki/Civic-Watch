import 'package:citizen/exports.dart';

class CreateReportScreen extends StatefulWidget {
  final Report? initialDraft;

  const CreateReportScreen({super.key, this.initialDraft});

  @override
  State<CreateReportScreen> createState() => CreateReportScreenState();
}

class CreateReportScreenState extends State<CreateReportScreen> {
  late Report reports;
  late int currentStep;
  ReportFlowMode flowMode = ReportFlowMode.create;
  Timer? _debounceTimer;
  bool _canPop = false;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialDraft != null) {
      reports = widget.initialDraft!;
      currentStep = reports.firstIncompleteStep;
    } else {
      reports = Report.createDraft(id: const Uuid().v4(), userId: '');
      currentStep = 0;
      // Immediately save the new draft
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<DraftProvider>().saveDraft(reports);
      });
    }
    _loadUser();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final user = await AppPreferences.getUser();
    if (mounted) {
      setState(() {
        reports = reports.copyWith(userId: user['username'] ?? 'anonymous');
      });
      // Update draft with userId
      context.read<DraftProvider>().updateDraft(reports);
    }
  }

  void nextStep() {
    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    Navigator.of(context).maybePop();
  }

  void enterEditMode(int stepIndex) {
    setState(() {
      currentStep = stepIndex;
      flowMode = ReportFlowMode.edit;
    });
  }

  void exitEditMode() {
    setState(() {
      currentStep = 4; // Review step index
      flowMode = ReportFlowMode.create;
    });
  }

  void updateReport(Report updatedReport) {
    setState(() {
      reports = updatedReport;
    });
    // Autosave
    context.read<DraftProvider>().updateDraft(updatedReport);

    // Debounced notification
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        AppToast.info(context, 'Draft saved automatically');
      }
    });
  }

  Future<bool> _showExitConfirmation() async {
    if (_isExiting) return false;
    _isExiting = true;

    // If it's a new report and has some data
    final hasData =
        reports.category.isNotEmpty ||
        reports.images.isNotEmpty ||
        reports.title.isNotEmpty ||
        reports.description.isNotEmpty ||
        reports.address.isNotEmpty;

    if (!hasData) {
      // Delete draft if it exists but no data was entered
      await context.read<DraftProvider>().deleteDraft(reports.id);
      _isExiting = false;
      return true;
    }

    final result = await ReportDialogHelper.showExitConfirmation(context);

    if (result == 'save') {
      await context.read<DraftProvider>().updateDraft(reports);
      if (mounted) {
        await ReportDialogHelper.showSaveDraftExperience(context, () {
          if (mounted) {
            setState(() => _canPop = true);
            Future.microtask(() {
              if (mounted && context.canPop()) {
                context.pop();
              }
            });
          }
        });
      }
      // Keep _isExiting true as we are definitely leaving
      return false; // Exit handled by showSaveDraftExperience
    } else if (result == 'discard') {
      await context.read<DraftProvider>().deleteDraft(reports.id);
      _isExiting = false;
      return true;
    }

    _isExiting = false;
    return result == 'continue' ? false : false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _showExitConfirmation();
        if (shouldPop && mounted) {
          setState(() => _canPop = true);
          Future.microtask(() {
            if (mounted && context.canPop()) {
              context.pop();
            }
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          step: (currentStep + 1),
          onBack: previousStep,
          title: currentStep == 4 ? 'Review Report' : 'Raise Issue',
        ),
        body: Column(
          children: [
            const _DraftSavingIndicator(),
            _ProgressBar(currentStep: currentStep, totalSteps: 5),
            Expanded(
              child: SafeArea(top: false, child: _buildStep(currentStep)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return CategoryStep(
          draft: reports,
          onNext: nextStep,
          onBack: previousStep,
          mode: flowMode,
          onSave: exitEditMode,
          onUpdate: updateReport,
        );
      case 1:
        return PhotoStep(
          draft: reports,
          onNext: nextStep,
          onBack: previousStep,
          mode: flowMode,
          onSave: exitEditMode,
          onUpdate: updateReport,
        );
      case 2:
        return DetailsStep(
          draft: reports,
          onNext: nextStep,
          onBack: previousStep,
          mode: flowMode,
          onSave: exitEditMode,
          onUpdate: updateReport,
        );
      case 3:
        return LocationStep(
          draft: reports,
          onNext: nextStep,
          onBack: previousStep,
          mode: flowMode,
          onSave: exitEditMode,
          onUpdate: updateReport,
        );
      case 4:
        return ReviewStep(
          draft: reports,
          onBack: previousStep,
          title: 'Review Report',
          onEdit: enterEditMode,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _DraftSavingIndicator extends StatelessWidget {
  const _DraftSavingIndicator();

  @override
  Widget build(BuildContext context) {
    final isSaving = context.select<DraftProvider, bool>((p) => p.isSaving);
    if (isSaving) {
      return const AppLinearLoading();
    }
    return const SizedBox(height: 2);
  }
}

class _ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _ProgressBar({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (currentStep + 1) / totalSteps,
      minHeight: 4,
      color: AppColors.textPrimary,
      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
