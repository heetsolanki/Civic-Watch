import 'package:citizen/exports.dart';

class ReportLocalDataSource {
  final Box<Report> _reportBox = Hive.box<Report>(HiveBoxes.reports);

  Future<void> saveReport(Report report) async {
    await _reportBox.put(report.id, report);
  }

  Report? getReport(String id) {
    return _reportBox.get(id);
  }

  List<Report> getAllReports() {
    final reports = _reportBox.values.toList();

    reports.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return reports;
  }

  Future<void> updateReport(Report report) async {
    await _reportBox.put(report.id, report);
  }

  Future<void> deleteReport(String id) async {
    await _reportBox.delete(id);
  }

  Future<void> clearReport() async {
    await _reportBox.clear();
  }
}
