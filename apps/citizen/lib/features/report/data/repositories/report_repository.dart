import 'package:citizen/exports.dart';

class ReportRepository {
  ReportRepository(this._local);

  final ReportLocalDataSource _local;

  Future<void> saveReport(Report report) {
    return _local.saveReport(report);
  }

  Report? getReport(String id) {
    return _local.getReport(id);
  }

  List<Report> getReports() {
    return _local.getAllReports();
  }

  Future<void> updateReport(Report report) {
    return _local.updateReport(report);
  }

  Future<void> deleteReport(String id) {
    return _local.deleteReport(id);
  }
}
