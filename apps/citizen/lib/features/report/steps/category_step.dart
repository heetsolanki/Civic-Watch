import 'package:citizen/exports.dart';
import '../widgets/category_card.dart';

class CategoryStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Report draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;
  final ValueChanged<Report> onUpdate;

  const CategoryStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
    required this.onUpdate,
  });

  @override
  State<CategoryStep> createState() => _CategoryStepState();
}

class _CategoryStepState extends State<CategoryStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Select a Category',
              subtitle:
                  'Choose the category that best fits the issue you want to report.',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: AppCategories.categories.length,
                itemBuilder: (context, index) {
                  final entry = AppCategories.categories.entries.elementAt(
                    index,
                  );
                  return CategoryCard(
                    label: entry.key,
                    icon: entry.value,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      widget.onUpdate(
                        widget.draft.copyWith(category: entry.key),
                      );
                    },
                    isSelected: widget.draft.category == entry.key,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: widget.mode == ReportFlowMode.edit
                  ? "Save Changes"
                  : "Continue",
              suffixIcon: widget.mode == ReportFlowMode.create
                  ? const Icon(Icons.keyboard_arrow_right_rounded, size: 20)
                  : null,
              onPressed: widget.draft.category.isNotEmpty
                  ? (widget.mode == ReportFlowMode.edit
                        ? widget.onSave
                        : widget.onNext)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
