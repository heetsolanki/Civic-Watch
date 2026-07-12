import 'package:citizen/exports.dart';
import 'package:citizen/features/report/data/local/draft_local_data_source.dart';

class DraftRepository {
  DraftRepository(this._local);

  final DraftLocalDataSource _local;

  Future<void> saveDraft(Report draft) {
    return _local.saveDraft(draft);
  }

  Report? getDraft(String id) {
    return _local.getDraft(id);
  }

  List<Report> getDrafts() {
    return _local.getAllDrafts();
  }

  Future<void> updateDraft(Report draft) {
    return _local.updateDraft(draft);
  }

  Future<void> deleteDraft(String id) {
    return _local.deleteDraft(id);
  }

  Future<void> clearDrafts() {
    return _local.clearDrafts();
  }
}
