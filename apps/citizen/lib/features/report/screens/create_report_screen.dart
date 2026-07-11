import 'package:citizen/exports.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => CreateReportScreenState();
}

class CreateReportScreenState extends State<CreateReportScreen> {
  final ReportDraft reports = ReportDraft();
  int currentStep = 0;
  ReportFlowMode flowMode = ReportFlowMode.create;

  void nextStep() {
    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    context.pop();
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

  @override
  Widget build(BuildContext context) {
    final steps = [
      CategoryStep(
        draft: reports,
        onNext: nextStep,
        onBack: previousStep,
        mode: flowMode,
        onSave: exitEditMode,
      ),
      PhotoStep(
        draft: reports,
        onNext: nextStep,
        onBack: previousStep,
        mode: flowMode,
        onSave: exitEditMode,
      ),
      DetailsStep(
        draft: reports,
        onNext: nextStep,
        onBack: previousStep,
        mode: flowMode,
        onSave: exitEditMode,
      ),
      LocationStep(
        draft: reports,
        onNext: nextStep,
        onBack: previousStep,
        mode: flowMode,
        onSave: exitEditMode,
      ),
      ReviewStep(
        draft: reports,
        onBack: previousStep,
        title: 'Review Report',
        onEdit: enterEditMode,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        step: (currentStep + 1),
        onBack: previousStep,
        title: currentStep == 4 ? 'Review Report' : 'Raise Issue',
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentStep + 1) / steps.length,
            minHeight: 4,
            color: AppColors.textPrimary,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          Expanded(child: SafeArea(top: false, child: steps[currentStep])),
        ],
      ),
    );
  }
}
