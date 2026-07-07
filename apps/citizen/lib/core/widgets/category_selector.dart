import 'package:citizen/exports.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          spacing: 12,
          children: categories.map((category) {
            final isSelected = selectedCategory == category;
            return ChoiceChip(
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.cardColor,
              labelStyle: GoogleFonts.openSans(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.1),
                  width: 1,
                ),
              ),
              showCheckmark: false,
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(category),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onCategorySelected(category);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
