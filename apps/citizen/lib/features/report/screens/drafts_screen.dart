import 'package:citizen/exports.dart';
import '../widgets/draft_card.dart';

class DraftsScreen extends StatelessWidget {
  const DraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Draft Reports',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Continue where you left off',
              style: GoogleFonts.openSans(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Consumer<DraftProvider>(
        builder: (context, provider, child) {
          final drafts = provider.drafts;
          if (drafts.isEmpty) {
            return const _EmptyDraftsState();
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: drafts.length,
            itemBuilder: (context, index) {
              final draft = drafts[index];
              return Dismissible(
                key: ValueKey(draft.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) => _showDeleteConfirmation(context),
                onDismissed: (direction) {
                  context.read<DraftProvider>().deleteDraft(draft.id);
                  AppToast.success(context, 'Draft deleted');
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                child: DraftCard(draft: draft),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
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
  }
}

class _EmptyDraftsState extends StatelessWidget {
  const _EmptyDraftsState();

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.drafts_outlined,
      title: 'No Drafts Yet',
      description: 'Reports you save before submitting will appear here.',
      actionText: 'Create Report',
      onAction: () => context.push('/create-report'),
    );
  }
}
