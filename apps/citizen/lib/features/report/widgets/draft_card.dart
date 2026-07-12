import 'package:citizen/exports.dart';

class DraftCard extends StatelessWidget {
  final Report draft;

  const DraftCard({super.key, required this.draft});

  @override
  Widget build(BuildContext context) {
    final completion = draft.completionPercentage;
    final progressSteps = (completion * 5).toInt();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: AppColors.cardColor,
      child: InkWell(
        onTap: () => context.push('/create-report', extra: draft),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      getCategoryIcon(draft.category),
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          draft.title.isEmpty ? 'Untitled Report' : draft.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Last edited: ${AppDateFormatter.formatDateTime(draft.updatedAt)}',
                          style: GoogleFonts.openSans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          title: 'Delete Draft?',
                          description: 'This action cannot be undone.',
                          confirmText: 'Delete',
                          confirmColor: AppColors.danger,
                          icon: Icons.delete_forever_outlined,
                          iconColor: AppColors.danger,
                          onConfirm: () {},
                        ),
                      );
                      if (confirm == true && context.mounted) {
                        context.read<DraftProvider>().deleteDraft(draft.id);
                        AppToast.success(context, 'Draft deleted');
                      }
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.danger,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$progressSteps / 5 Completed',
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${(completion * 100).toInt()}%',
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: completion,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Continue Editing',
                onPressed: () => context.push('/create-report', extra: draft),
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
