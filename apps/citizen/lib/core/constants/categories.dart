import 'package:citizen/exports.dart';

class AppCategories {
  static const Map<String, IconData> categories = {
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

  static List<String> get names => categories.keys.toList();

  static IconData getIcon(String name) {
    return categories[name] ?? Icons.more_horiz_rounded;
  }
}
