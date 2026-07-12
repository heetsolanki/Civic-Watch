import 'package:citizen/exports.dart';
import 'package:citizen/features/report/data/repositories/draft_repository.dart';

class DraftProvider extends ChangeNotifier {
  DraftProvider(this._repository);

  final DraftRepository _repository;

  List<Report> _drafts = [];
  List<Report> get drafts => _drafts;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> loadDrafts() async {
    _drafts = _repository.getDrafts();
    notifyListeners();
  }

  Future<void> saveDraft(Report draft) async {
    _isSaving = true;
    notifyListeners();

    final draftToSave = draft.copyWith(updatedAt: DateTime.now());
    await _repository.saveDraft(draftToSave);
    await loadDrafts();

    _isSaving = false;
    notifyListeners();
  }

  Future<void> deleteDraft(String id) async {
    await _repository.deleteDraft(id);
    await loadDrafts();
  }

  Future<void> updateDraft(Report draft) async {
    _isSaving = true;
    notifyListeners();

    final draftToUpdate = draft.copyWith(updatedAt: DateTime.now());
    await _repository.updateDraft(draftToUpdate);
    await loadDrafts();

    _isSaving = false;
    notifyListeners();
  }

  Future<void> clearDrafts() async {
    await _repository.clearDrafts();
    await loadDrafts();
  }
}
