import 'package:citizen/exports.dart';

IconData getCategoryIcon(String category) {
  // Try exact match first
  if (AppCategories.categories.containsKey(category)) {
    return AppCategories.categories[category]!;
  }

  // Try case-insensitive match
  for (final entry in AppCategories.categories.entries) {
    if (entry.key.toLowerCase() == category.toLowerCase()) {
      return entry.value;
    }
  }

  return Icons.more_horiz_rounded;
}
