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
  final Map<String, IconData> categories = {
    'Roads': Icons.add_road,
    'Utilities': Icons.lightbulb_outline,
    'Cleanliness': Icons.cleaning_services,
    'Environment': Icons.forest,
    'Public Property': Icons.location_city,
    'Traffic & Parking': Icons.traffic,
    'Public Transport': Icons.directions_bus,
    'Construction': Icons.construction,
    'Animals': Icons.pets,
    'Public Safety': Icons.health_and_safety,
    'Others': Icons.more_horiz,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a category',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: categories.entries.map((entry) {
                  return CategoryCard(
                    label: entry.key,
                    icon: entry.value,
                    onTap: () {
                      setState(() {
                        widget.draft.category = entry.key;
                      });
                    },
                    isSelected: widget.draft.category == entry.key,
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AppButton(
                text: widget.mode == ReportFlowMode.edit ? "Save Changes" : "Continue",
                suffixIcon: widget.mode == ReportFlowMode.create 
                    ? const Icon(Icons.keyboard_arrow_right, size: 20)
                    : null,
                onPressed: widget.draft.category != null 
                    ? (widget.mode == ReportFlowMode.edit ? widget.onSave : widget.onNext)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
