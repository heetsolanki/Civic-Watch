import 'package:citizen/exports.dart';
import '../widgets/category_card.dart';

class CategoryStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final ReportDraft draft;
  final ReportFlowMode mode;
  final VoidCallback onSave;

  const CategoryStep({
    super.key,
    required this.onNext,
    required this.draft,
    required this.onBack,
    this.mode = ReportFlowMode.create,
    required this.onSave,
  });

  @override
  State<CategoryStep> createState() => _CategoryStepState();
}

class _CategoryStepState extends State<CategoryStep> {
  static const Map<String, IconData> _categories = {
    'Roads': Icons.add_road_rounded,
    'Utilities': Icons.lightbulb_outline_rounded,
    'Cleanliness': Icons.cleaning_services_rounded,
    'Environment': Icons.forest_rounded,
    'Public Property': Icons.location_city_rounded,
    'Traffic & Parking': Icons.traffic_rounded,
    'Public Transport': Icons.directions_bus_rounded,
    'Construction': Icons.construction_rounded,
    'Animals': Icons.pets_rounded,
    'Public Safety': Icons.health_and_safety_rounded,
    'Others': Icons.more_horiz_rounded,
  };

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
              subtitle: 'Choose the category that best fits the issue you want to report.',
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
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final entry = _categories.entries.elementAt(index);
                  return CategoryCard(
                    label: entry.key,
                    icon: entry.value,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => widget.draft.category = entry.key);
                    },
                    isSelected: widget.draft.category == entry.key,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: widget.mode == ReportFlowMode.edit ? "Save Changes" : "Continue",
              suffixIcon: widget.mode == ReportFlowMode.create 
                  ? const Icon(Icons.keyboard_arrow_right_rounded, size: 20)
                  : null,
              onPressed: widget.draft.category != null 
                  ? (widget.mode == ReportFlowMode.edit ? widget.onSave : widget.onNext)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
