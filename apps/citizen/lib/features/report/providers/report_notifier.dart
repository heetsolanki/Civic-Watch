import 'package:citizen/exports.dart';

class ReportProvider extends ChangeNotifier {
  ReportProvider(this._repository);

  final ReportRepository _repository;

  List<Report> _reports = [];

  List<Report> get reports => _reports;

  Future<void> loadReports() async {
    _reports = _repository.getReports();
    notifyListeners();
  }

  Future<void> addReport(Report report) async {
    await _repository.saveReport(report);
    await loadReports();
  }

  Future<void> deleteReport(String id) async {
    await _repository.deleteReport(id);
    await loadReports();
  }
}
