import 'package:citizen/exports.dart';

IconData getCategoryIcon(String category) {
  switch (category.toLowerCase()) {
    case 'roads':
      return Icons.edit_road;
    case 'utilities':
      return Icons.lightbulb;
    case 'cleanliness':
      return Icons.cleaning_services;
    case 'environment':
      return Icons.nature_people;
    case 'public property':
      return Icons.location_city;
    case 'traffic & parking':
      return Icons.traffic;
    case 'public transport':
      return Icons.directions_bus;
    case 'construction':
      return Icons.construction;
    case 'animals':
      return Icons.pets;
    case 'public safety':
      return Icons.security;
    default:
      return Icons.category;
  }
}
