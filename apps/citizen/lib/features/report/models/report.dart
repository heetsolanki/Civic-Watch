import 'package:citizen/core/constants/report_status.dart';
import 'package:citizen/exports.dart';

part 'report.g.dart';

@HiveType(typeId: 0)
class Report extends HiveObject {
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

  Report({
    required this.id,
    this.category = '',
    this.title = '',
    this.description = '',
    this.images = const [],
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.address = '',
    this.status = 'draft',
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Report.createDraft({required String id, required String userId}) {
    final now = DateTime.now();
    return Report(
      id: id,
      userId: userId,
      createdAt: now,
      updatedAt: now,
      status: ReportStatus.draft,
    );
  }

  Report copyWith({
    String? id,
    String? category,
    String? title,
    String? description,
    List<String>? images,
    double? latitude,
    double? longitude,
    String? address,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Report(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  bool get isComplete =>
      category.isNotEmpty &&
      images.isNotEmpty &&
      title.trim().length >= 10 &&
      description.trim().length >= 20 &&
      latitude != 0.0 &&
      longitude != 0.0 &&
      address.isNotEmpty;

  int get firstIncompleteStep {
    if (category.isEmpty) return 0;
    if (images.isEmpty) return 1;
    if (title.trim().length < 10 || description.trim().length < 20) return 2;
    if (latitude == 0.0 || longitude == 0.0 || address.isEmpty) return 3;
    return 4;
  }

  double get completionPercentage {
    double progress = 0;
    if (category.isNotEmpty) progress += 0.2;
    if (images.isNotEmpty) progress += 0.2;
    if (title.trim().length >= 10 && description.trim().length >= 20) {
      progress += 0.2;
    }
    if (latitude != 0.0 && longitude != 0.0 && address.isNotEmpty) {
      progress += 0.2;
    }
    if (isComplete) progress += 0.2;
    return progress;
  }
}
