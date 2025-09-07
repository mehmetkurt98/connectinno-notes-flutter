import 'package:hive/hive.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/logger_mixin.dart';
import '../models/note_model.dart';
import '../models/pending_operation_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getCachedNotes();
  Future<List<NoteModel>> getCachedNotesByOwner(String ownerUid);
  Future<void> cacheNotes(List<NoteModel> notes);
  Future<void> saveNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String noteId);
  Future<void> savePendingOp(PendingOperationModel op);
  Future<List<PendingOperationModel>> getPendingOps();
  Future<void> removePendingOp(String opId);
  Future<void> clearCache();
}

class NotesLocalDataSourceImpl
    with LoggerMixin
    implements NotesLocalDataSource {
  NotesLocalDataSourceImpl() {
    initLogger();
  }

  @override
  Future<List<NoteModel>> getCachedNotes() async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    final box = Hive.box<NoteModel>(AppConstants.notesBoxName);
    final notes = box.values.toList();

    // Notları updatedAt'e göre azalan sırada sırala (en yeni önce)
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    // Debug: Cache'de kaç not var (sadece sayı)
    logInfo('🔍 Cache\'den ${notes.length} not yüklendi');

    return notes;
  }

  @override
  Future<List<NoteModel>> getCachedNotesByOwner(String ownerUid) async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    final box = Hive.box<NoteModel>(AppConstants.notesBoxName);
    final notes =
        box.values.where((note) => note.ownerUid == ownerUid).toList();

    // Notları updatedAt'e göre azalan sırada sırala (en yeni önce)
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return notes;
  }

  @override
  Future<void> cacheNotes(List<NoteModel> notes) async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    final box = Hive.box<NoteModel>(AppConstants.notesBoxName);

    // Sadece bu notları güncelle, tüm cache'i temizleme
    for (final note in notes) {
      await box.put(note.id, note);
    }
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    final box = Hive.box<NoteModel>(AppConstants.notesBoxName);
    await box.put(note.id, note);

    // Debug: Not kaydedildi
    logInfo(
      '💾 Not kaydedildi: ${note.title} (ID: ${note.id}, Owner: ${note.ownerUid})',
    );
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    final box = Hive.box<NoteModel>(AppConstants.notesBoxName);
    await box.put(note.id, note);
  }

  @override
  Future<void> deleteNote(String noteId) async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    final box = Hive.box<NoteModel>(AppConstants.notesBoxName);
    await box.delete(noteId);
  }

  @override
  Future<void> savePendingOp(PendingOperationModel op) async {
    if (!Hive.isBoxOpen(AppConstants.pendingOpsBoxName)) {
      await Hive.openBox<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    }
    final box = Hive.box<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    await box.put(op.id, op);
  }

  @override
  Future<List<PendingOperationModel>> getPendingOps() async {
    if (!Hive.isBoxOpen(AppConstants.pendingOpsBoxName)) {
      await Hive.openBox<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    }
    final box = Hive.box<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    return box.values.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  @override
  Future<void> removePendingOp(String opId) async {
    if (!Hive.isBoxOpen(AppConstants.pendingOpsBoxName)) {
      await Hive.openBox<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    }
    final box = Hive.box<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    await box.delete(opId);
  }

  @override
  Future<void> clearCache() async {
    if (!Hive.isBoxOpen(AppConstants.notesBoxName)) {
      await Hive.openBox<NoteModel>(AppConstants.notesBoxName);
    }
    if (!Hive.isBoxOpen(AppConstants.pendingOpsBoxName)) {
      await Hive.openBox<PendingOperationModel>(AppConstants.pendingOpsBoxName);
    }
    final notesBox = Hive.box<NoteModel>(AppConstants.notesBoxName);
    final pendingOpsBox = Hive.box<PendingOperationModel>(
      AppConstants.pendingOpsBoxName,
    );
    await notesBox.clear();
    await pendingOpsBox.clear();
  }
}
