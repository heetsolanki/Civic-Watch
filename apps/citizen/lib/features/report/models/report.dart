import 'package:citizen/exports.dart';

part 'report.g.dart';

@HiveType(typeId: 0)
class Report extends HiveObject {
  Report({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<String> images;

  @HiveField(5)
  final double latitude;

  @HiveField(6)
  final double longitude;

  @HiveField(7)
  final String address;

  @HiveField(8)
  final String status;

  @HiveField(9)
  final DateTime createdAt;

  @HiveField(10)
  final DateTime updatedAt;

  @HiveField(11)
  final String userId;
}
