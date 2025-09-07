import 'package:dio/dio.dart';
import '../models/note_model.dart';
import '../models/note_summary_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteModel>> fetchNotes();
  Future<NoteModel> createNoteRemote(NoteModel note);
  Future<NoteModel> updateNoteRemote(NoteModel note);
  Future<void> deleteNoteRemote(String id);
  Future<NoteSummaryModel> summarizeNote(String content);
  Future<List<String>> extractTodos(String content);
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  final Dio _dio;

  NotesRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<NoteModel>> fetchNotes() async {
    try {
      // Backend zaten kullanıcı izolasyonu yapıyor, sadece endpoint'i çağır
      final response = await _dio.get('/api/notes');
      final List<dynamic> notesJson = response.data;
      final notes = notesJson.map((json) => NoteModel.fromJson(json)).toList();

      // Notları updatedAt'e göre azalan sırada sırala (en yeni önce)
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return notes;
    } on DioException catch (e) {
      throw Exception('Failed to fetch notes: ${e.message}');
    }
  }

  @override
  Future<NoteModel> createNoteRemote(NoteModel note) async {
    try {
      print('🚀 Remote: POST /api/notes - ${note.title}');
      print('📤 Remote: Gönderilen data: ${note.toJson()}');
      final response = await _dio.post('/api/notes', data: note.toJson());
      print('📥 Remote: Response status: ${response.statusCode}');
      print('📥 Remote: Response data: ${response.data}');
      return NoteModel.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ Remote: DioException - ${e.message}');
      print('❌ Remote: Response data: ${e.response?.data}');
      print('❌ Remote: Status code: ${e.response?.statusCode}');
      throw Exception('Failed to create note: ${e.message}');
    }
  }

  @override
  Future<NoteModel> updateNoteRemote(NoteModel note) async {
    try {
      final response = await _dio.put(
        '/api/notes/${note.id}',
        data: note.toJson(),
      );
      return NoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update note: ${e.message}');
    }
  }

  @override
  Future<void> deleteNoteRemote(String id) async {
    try {
      await _dio.delete('/api/notes/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete note: ${e.message}');
    }
  }

  @override
  Future<NoteSummaryModel> summarizeNote(String content) async {
    try {
      final response = await _dio.post(
        '/api/notes/summarize',
        data: {'content': content},
      );
      return NoteSummaryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to summarize note: ${e.message}');
    }
  }

  @override
  Future<List<String>> extractTodos(String content) async {
    try {
      final response = await _dio.post(
        '/api/notes/extract-todos',
        data: {'content': content},
      );
      final data = response.data;
      if (data['hasTodos'] == true) {
        return List<String>.from(data['todos']);
      }
      return [];
    } on DioException catch (e) {
      throw Exception('Failed to extract todos: ${e.message}');
    }
  }
}
