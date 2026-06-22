import 'package:citizen/exports.dart';

class IssueData {
  final String image;
  final IconData icon;
  final String category;
  final String title;
  final String location;
  final String status;
  final String supportedCount;

  const IssueData({
    required this.image,
    required this.icon,
    required this.category,
    required this.title,
    required this.location,
    this.status = 'In Progress',
    required this.supportedCount,
  });
}

final issueDataList = [
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.water_drop,
    category: 'Utilities',
    title: 'Water Leakage in Main Street',
    location: 'Downtown, Sector 4',
    supportedCount: '24',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.lightbulb,
    category: 'Infrastructure',
    title: 'Broken Street Light',
    location: 'Oakwood Avenue',
    supportedCount: '12',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.delete_outline,
    category: 'Sanitation',
    title: 'Overflowing Garbage Bin',
    location: 'Central Park North',
    supportedCount: '45',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.edit_road,
    category: 'Roads',
    title: 'Large Pothole near School',
    location: 'Westside High Road',
    supportedCount: '89',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.edit_road,
    category: 'Roads',
    title: 'Broken Sidewalk near Hospital',
    location: '64th Street North Avenue',
    supportedCount: '52',
  ),
];
