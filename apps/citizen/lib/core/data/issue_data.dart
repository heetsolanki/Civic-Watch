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
  // Roads
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
    icon: Icons.add_road,
    category: 'Roads',
    title: 'Broken Sidewalk near Hospital',
    location: '64th Street North Avenue',
    supportedCount: '52',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.grid_on,
    category: 'Roads',
    title: 'Loose Paving Stones',
    location: 'Central Plaza',
    supportedCount: '34',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.minor_crash,
    category: 'Roads',
    title: 'Dangerous Road Crack',
    location: 'Bakers Street',
    supportedCount: '21',
  ),

  // Utilities
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
    icon: Icons.plumbing,
    category: 'Utilities',
    title: 'Burst Pipe',
    location: 'Sunset Blvd',
    supportedCount: '42',
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
    icon: Icons.bolt,
    category: 'Utilities',
    title: 'Frequent Power Outage',
    location: 'Old Town',
    supportedCount: '156',
  ),

  // Cleanliness
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.delete_outline,
    category: 'Cleanliness',
    title: 'Overflowing Garbage Bin',
    location: 'Central Park North',
    supportedCount: '45',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.cleaning_services,
    category: 'Cleanliness',
    title: 'Illegal Dumping',
    location: 'Willow Creek',
    supportedCount: '67',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.coronavirus,
    category: 'Cleanliness',
    title: 'Overflowing Sewage',
    location: 'Harbor Road',
    supportedCount: '95',
  ),

  // Environment
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
    icon: Icons.nature,
    category: 'Environment',
    title: 'Overgrown Vegetation',
    location: 'Riverbank',
    supportedCount: '10',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.forest,
    category: 'Environment',
    title: 'Dead Tree',
    location: 'Pine Street',
    supportedCount: '14',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.cloud_off,
    category: 'Environment',
    title: 'Heavy Smoke Emission',
    location: 'Industrial Zone',
    supportedCount: '112',
  ),

  // Public Property
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.chair,
    category: 'Public Property',
    title: 'Vandalized Park Bench',
    location: 'City Gardens',
    supportedCount: '21',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.location_city,
    category: 'Public Property',
    title: 'Graffiti on Library Wall',
    location: 'Downtown',
    supportedCount: '29',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.deck,
    category: 'Public Property',
    title: 'Broken Fountain',
    location: 'Memorial Square',
    supportedCount: '38',
  ),

  // Traffic & Parking
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.traffic,
    category: 'Traffic & Parking',
    title: 'Broken Traffic Light',
    location: 'Intersection A',
    supportedCount: '120',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.local_parking,
    category: 'Traffic & Parking',
    title: 'Illegal Parking Blocking Lane',
    location: 'Market Street',
    supportedCount: '56',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.wrong_location,
    category: 'Traffic & Parking',
    title: 'Missing Road Sign',
    location: 'New Highway Exit',
    supportedCount: '15',
  ),

  // Public Transport
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.directions_bus,
    category: 'Public Transport',
    title: 'Damaged Bus Shelter',
    location: 'North Station',
    supportedCount: '44',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.train,
    category: 'Public Transport',
    title: 'Subway Elevator Out of Order',
    location: 'Central Station',
    supportedCount: '189',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.commute,
    category: 'Public Transport',
    title: 'Broken Ticket Machine',
    location: 'West Terminal',
    supportedCount: '32',
  ),

  // Construction
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.construction,
    category: 'Construction',
    title: 'Unsafe Scaffolding',
    location: 'High-rise Project 4',
    supportedCount: '77',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.engineering,
    category: 'Construction',
    title: 'Construction Debris on Road',
    location: 'Bridge Avenue',
    supportedCount: '54',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.fence,
    category: 'Construction',
    title: 'Missing Safety Fence',
    location: 'Dig Site C',
    supportedCount: '23',
  ),

  // Animals
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.pets,
    category: 'Animals',
    title: 'Aggressive Stray Dogs',
    location: 'Residential Area 5',
    supportedCount: '143',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.cruelty_free,
    category: 'Animals',
    title: 'Injured Bird',
    location: 'Town Square',
    supportedCount: '12',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.bug_report,
    category: 'Animals',
    title: 'Wasp Nest near Playground',
    location: 'Sunny Park',
    supportedCount: '88',
  ),

  // Public Safety
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.warning_amber_rounded,
    category: 'Public Safety',
    title: 'Exposed Electrical Wires',
    location: 'Market Square East',
    supportedCount: '31',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.car_repair,
    category: 'Public Safety',
    title: 'Abandoned Vehicle',
    location: 'Industrial Area',
    supportedCount: '15',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.volume_up,
    category: 'Public Safety',
    title: 'Noise Complaint',
    location: 'Residential Zone 3',
    supportedCount: '56',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.lightbulb,
    category: 'Public Safety',
    title: 'Broken Street Light',
    location: 'Oakwood Avenue',
    supportedCount: '12',
  ),

  // Other
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.more_horiz,
    category: 'Other',
    title: 'General Maintenance Request',
    location: 'Sector 12',
    supportedCount: '5',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.help_outline,
    category: 'Other',
    title: 'Unidentified Civic Issue',
    location: 'Bridge Road',
    supportedCount: '9',
  ),
  const IssueData(
    image: 'assets/images/wallpaper.jpg',
    icon: Icons.campaign,
    category: 'Other',
    title: 'Damaged Public Speaker',
    location: 'Bus Stand',
    supportedCount: '27',
  ),
];
