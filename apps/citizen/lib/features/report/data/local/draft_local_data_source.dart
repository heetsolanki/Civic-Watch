import 'package:citizen/exports.dart';

class DraftLocalDataSource {
  final Box<Report> _draftBox = Hive.box<Report>(HiveBoxes.drafts);

  Future<void> saveDraft(Report draft) async {
    await _draftBox.put(draft.id, draft);
  }

  Report? getDraft(String id) {
    return _draftBox.get(id);
  }

  List<Report> getAllDrafts() {
    final drafts = _draftBox.values.toList();
    // Sort by updatedAt descending
    drafts.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return drafts;
  }

  Future<void> updateDraft(Report draft) async {
    await _draftBox.put(draft.id, draft);
  }

  Future<void> deleteDraft(String id) async {
    await _draftBox.delete(id);
  }

  Future<void> clearDrafts() async {
    await _draftBox.clear();
  }
}
