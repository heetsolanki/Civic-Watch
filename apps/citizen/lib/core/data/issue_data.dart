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
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.park,
    category: 'Environment',
    title: 'Fallen Tree Blocking Path',
    location: 'Greenwood Park Trail',
    supportedCount: '18',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.warning_amber_rounded,
    category: 'Safety',
    title: 'Exposed Electrical Wires',
    location: 'Market Square East',
    supportedCount: '31',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.delete_forever,
    category: 'Sanitation',
    title: 'Illegal Dumping',
    location: 'Willow Creek',
    supportedCount: '67',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.plumbing,
    category: 'Utilities',
    title: 'Burst Pipe',
    location: 'Sunset Blvd',
    supportedCount: '42',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.car_repair,
    category: 'Safety',
    title: 'Abandoned Vehicle',
    location: 'Industrial Area',
    supportedCount: '15',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.format_paint,
    category: 'Infrastructure',
    title: 'Graffiti on Wall',
    location: 'Metro Station',
    supportedCount: '29',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.nature,
    category: 'Environment',
    title: 'Overgrown Vegetation',
    location: 'Riverbank',
    supportedCount: '10',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.signpost,
    category: 'Roads',
    title: 'Missing Street Sign',
    location: 'New Development',
    supportedCount: '5',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.waves,
    category: 'Utilities',
    title: 'Clogged Storm Drain',
    location: 'Eastside',
    supportedCount: '73',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.chair,
    category: 'Infrastructure',
    title: 'Vandalized Park Bench',
    location: 'City Gardens',
    supportedCount: '21',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.volume_up,
    category: 'Safety',
    title: 'Noise Complaint',
    location: 'Residential Zone 3',
    supportedCount: '56',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.grid_on,
    category: 'Roads',
    title: 'Loose Paving Stones',
    location: 'Plaza',
    supportedCount: '34',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.traffic,
    category: 'Roads',
    title: 'Broken Traffic Light',
    location: 'Intersection A',
    supportedCount: '120',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.coronavirus,
    category: 'Sanitation',
    title: 'Overflowing Sewage',
    location: 'Harbor Road',
    supportedCount: '95',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.forest,
    category: 'Environment',
    title: 'Dead Tree',
    location: 'Pine Street',
    supportedCount: '14',
  ),
];
