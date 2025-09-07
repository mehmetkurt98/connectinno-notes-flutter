import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import '../entities/note_summary.dart';

abstract class NotesRepository {
  Future<List<Note>> getAllNotes(String ownerUid);
  Future<List<Note>> getCachedNotes(String ownerUid);
  Future<Note> createNote(Note note);
  Future<Note> updateNote(Note note);
  Future<void> deleteNote(String noteId);
  Future<void> syncPending();
  Future<Either<Failure, NoteSummary>> summarizeNote(String content);
  Future<Either<Failure, List<String>>> extractTodos(String content);
}
