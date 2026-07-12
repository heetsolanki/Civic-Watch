import 'package:citizen/exports.dart';

/// Helper class to handle report-related dialog experiences.
class ReportDialogHelper {
  ReportDialogHelper._();

  static Future<void> showSaveDraftExperience(
    BuildContext context,
    VoidCallback onComplete,
  ) async {
    await _showFullExperience(
      context,
      loadingTitle: 'Saving Draft...',
      loadingDesc: 'We are securing your progress so you can continue later.',
      successTitle: 'Draft Saved',
      successDesc: 'Your report has been saved to your drafts successfully.',
      onComplete: onComplete,
    );
  }

  static Future<void> showSubmittingExperience(
    BuildContext context,
    VoidCallback onComplete,
  ) async {
    await _showFullExperience(
      context,
      loadingTitle: 'Submitting Report...',
      loadingDesc:
          'Please wait while we upload your report and notify the local authority.',
      successTitle: 'Report Submitted',
      successDesc:
          'Your report has been successfully submitted. Thank you for your civic contribution!',
      onComplete: onComplete,
    );
  }

  static Future<void> _showFullExperience(
    BuildContext context, {
    required String loadingTitle,
    required String loadingDesc,
    required String successTitle,
    required String successDesc,
    required VoidCallback onComplete,
  }) async {
    final loadingCanPop = ValueNotifier(false);
    _showActionDialog(
      context,
      title: loadingTitle,
      description: loadingDesc,
      isLoading: true,
      canPopNotifier: loadingCanPop,
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;
    loadingCanPop.value = true;
    if (context.canPop()) {
      context.pop(); // Close loading
    }

    final successCanPop = ValueNotifier(false);
    _showActionDialog(
      context,
      title: successTitle,
      description: successDesc,
      isSuccess: true,
      canPopNotifier: successCanPop,
    );

    await Future.delayed(const Duration(milliseconds: 1500));

    if (!context.mounted) return;
    successCanPop.value = true;
    if (context.canPop()) {
      context.pop(); // Close success
    }
    
    onComplete();
  }

  static void _showActionDialog(
    BuildContext context, {
    required String title,
    required String description,
    bool isLoading = false,
    bool isSuccess = false,
    required ValueNotifier<bool> canPopNotifier,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ValueListenableBuilder<bool>(
        valueListenable: canPopNotifier,
        builder: (context, canPop, child) {
          return PopScope(
            canPop: canPop,
            child: ReportActionDialog(
              title: title,
              description: description,
              isLoading: isLoading,
              isSuccess: isSuccess,
            ),
          );
        },
      ),
    );
  }

  static Future<String?> showExitConfirmation(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => SaveDraftConfirmationDialog(
        onContinue: () {
          if (context.mounted && context.canPop()) {
            context.pop('continue');
          }
        },
        onDiscard: () {
          if (context.mounted && context.canPop()) {
            context.pop('discard');
          }
        },
        onSave: () {
          if (context.mounted && context.canPop()) {
            context.pop('save');
          }
        },
      ),
    );
  }
}
