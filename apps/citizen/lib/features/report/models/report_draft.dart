import 'package:citizen/exports.dart';

class ReportDraft {
  String? category;
  List<File> images = [];
  String title = '';
  String description = '';
  double? latitude;
  double? longitude;
  String? address;

  bool get isComplete =>
      category != null &&
      images.isNotEmpty &&
      title.length >= 10 &&
      description.length >= 20 &&
      latitude != null &&
      longitude != null &&
      (address?.isNotEmpty ?? false);
}
