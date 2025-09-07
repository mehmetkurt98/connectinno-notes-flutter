import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/note_summary.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_data_source.dart';
import '../datasources/notes_remote_data_source.dart';
import '../models/note_model.dart';
import '../models/note_summary_model.dart';
import '../models/pending_operation_model.dart';
import '../models/operation_type.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/logger_mixin.dart';

class NotesRepositoryImpl with LoggerMixin implements NotesRepository {
  final NotesRemoteDataSource _remoteDataSource;
  final NotesLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final Uuid _uuid = const Uuid();

  NotesRepositoryImpl({
    required NotesRemoteDataSource remoteDataSource,
    required NotesLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo {
    initLogger();
  }

  @override
  Future<List<Note>> getCachedNotes(String ownerUid) async {
    try {
      final cachedNotes = await _localDataSource.getCachedNotesByOwner(
        ownerUid,
      );
      return cachedNotes.map((model) => model.toEntity()).toList();
    } catch (e) {
      logError('❌ Cache\'den notlar alınırken hata: $e');
      return [];
    }
  }

  @override
  Future<List<Note>> getAllNotes(String ownerUid) async {
    try {
      logInfo('📝 Notlar yükleniyor...');

      // ÖNCE LOCAL CACHE'DEN KONTROL ET
      final cachedNotes = await _localDataSource.getCachedNotesByOwner(
        ownerUid,
      );
      logInfo('💾 Local cache\'den ${cachedNotes.length} not bulundu');

      // Eğer online isek ve local cache boşsa, remote'dan çek
      if (cachedNotes.isEmpty && await _networkInfo.isConnected) {
        logInfo('🔄 Local cache boş, remote\'dan notlar çekiliyor...');
        try {
          final remoteNotes = await _remoteDataSource.fetchNotes();
          logInfo('☁️ Remote\'dan ${remoteNotes.length} not alındı');

          // Remote notları local'e kaydet
          for (var note in remoteNotes) {
            await _localDataSource.saveNote(note);
          }

          return remoteNotes.map((model) => model.toEntity()).toList();
        } catch (e) {
          logWarning('⚠️ Remote\'dan not çekme başarısız: $e');
          // Hata durumunda boş liste döndür
          return [];
        }
      }

      // Local cache varsa hemen döndür, arka planda güncelleme yap
      if (cachedNotes.isNotEmpty) {
        _checkNetworkAndUpdateInBackground(ownerUid, cachedNotes);
      }

      // Local cache'i döndür
      return cachedNotes.map((model) => model.toEntity()).toList();
    } catch (e) {
      logError('❌ Notlar yüklenirken hata: $e');
      throw Exception('Failed to get notes: $e');
    }
  }

  /// Arka planda network kontrolü yap ve güncelleme yap
  Future<void> _checkNetworkAndUpdateInBackground(
    String ownerUid,
    List<NoteModel> cachedNotes,
  ) async {
    try {
      if (await _networkInfo.isConnected) {
        await _updateFromRemoteInBackground(ownerUid, cachedNotes);
      }
    } catch (e) {
      logWarning('⚠️ Network kontrolü başarısız: $e');
    }
  }

  /// Arka planda remote'dan güncelleme yap (UI'ı bloklamadan)
  Future<void> _updateFromRemoteInBackground(
    String ownerUid,
    List<NoteModel> cachedNotes,
  ) async {
    try {
      logInfo('🌐 Arka planda remote\'dan notlar çekiliyor...');
      final remoteNotes = await _remoteDataSource.fetchNotes();
      logInfo('☁️ Remote\'dan ${remoteNotes.length} not alındı');

      // Local cache ile remote verileri birleştir (last-write-wins)
      final mergedNotes = <NoteModel>[];
      final remoteNotesMap = {for (var note in remoteNotes) note.id: note};

      // Remote'daki notları ekle
      for (var remoteNote in remoteNotes) {
        mergedNotes.add(remoteNote);
        // Remote'dan gelen notu local'e kaydet
        await _localDataSource.saveNote(remoteNote);
      }

      // Local'deki notları ekle (remote'da yoksa veya daha yeni ise)
      for (var localNote in cachedNotes) {
        if (!remoteNotesMap.containsKey(localNote.id)) {
          // Remote'da yoksa local'i ekle
          mergedNotes.add(localNote);
        } else {
          // Remote'da varsa, hangisi daha yeni kontrol et
          final remoteNote = remoteNotesMap[localNote.id]!;
          if (localNote.updatedAt.isAfter(remoteNote.updatedAt)) {
            // Local daha yeni, local'i kullan
            final index = mergedNotes.indexWhere((n) => n.id == localNote.id);
            if (index != -1) {
              mergedNotes[index] = localNote;
            }
          }
        }
      }

      logInfo('✅ Arka planda ${mergedNotes.length} not birleştirildi');
    } catch (e) {
      logWarning('⚠️ Arka plan güncellemesi başarısız: $e');
      // Arka plan hatası UI'ı etkilemez
    }
  }

  @override
  Future<Note> createNote(Note note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);

      // Önce local'e kaydet
      await _localDataSource.saveNote(noteModel);

      // Eğer online isek, remote'a da gönder
      if (await _networkInfo.isConnected) {
        try {
          final createdNote = await _remoteDataSource.createNoteRemote(
            noteModel,
          );
          // Local cache'i güncelle
          await _localDataSource.updateNote(createdNote);
          return createdNote.toEntity();
        } catch (e) {
          // Remote'a kaydedilemezse pending operation olarak işaretle
          final pendingOp = PendingOperationModel(
            id: _uuid.v4(),
            operation: OperationType.create,
            noteId: note.id,
            payload: noteModel.toJson(),
            createdAt: DateTime.now(),
          );
          await _localDataSource.savePendingOp(pendingOp);
          return note;
        }
      } else {
        // Offline isek pending operation olarak işaretle
        final pendingOp = PendingOperationModel(
          id: _uuid.v4(),
          operation: OperationType.create,
          noteId: note.id,
          payload: noteModel.toJson(),
          createdAt: DateTime.now(),
        );
        await _localDataSource.savePendingOp(pendingOp);
        return note;
      }
    } catch (e) {
      throw Exception('Failed to create note: $e');
    }
  }

  @override
  Future<Note> updateNote(Note note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);

      // Önce local'e kaydet
      await _localDataSource.updateNote(noteModel);

      // Eğer online isek, remote'a da gönder
      if (await _networkInfo.isConnected) {
        try {
          final updatedNote = await _remoteDataSource.updateNoteRemote(
            noteModel,
          );
          // Local cache'i güncelle
          await _localDataSource.updateNote(updatedNote);
          return updatedNote.toEntity();
        } catch (e) {
          // Remote'a kaydedilemezse pending operation olarak işaretle
          final pendingOp = PendingOperationModel(
            id: _uuid.v4(),
            operation: OperationType.update,
            noteId: note.id,
            payload: noteModel.toJson(),
            createdAt: DateTime.now(),
          );
          await _localDataSource.savePendingOp(pendingOp);
          return note;
        }
      } else {
        // Offline isek pending operation olarak işaretle
        final pendingOp = PendingOperationModel(
          id: _uuid.v4(),
          operation: OperationType.update,
          noteId: note.id,
          payload: noteModel.toJson(),
          createdAt: DateTime.now(),
        );
        await _localDataSource.savePendingOp(pendingOp);
        return note;
      }
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      // Önce local'den sil
      await _localDataSource.deleteNote(noteId);

      // Eğer online isek, remote'dan da sil
      if (await _networkInfo.isConnected) {
        try {
          await _remoteDataSource.deleteNoteRemote(noteId);
        } catch (e) {
          // Remote'dan silinemezse pending operation olarak işaretle
          final pendingOp = PendingOperationModel(
            id: _uuid.v4(),
            operation: OperationType.delete,
            noteId: noteId,
            createdAt: DateTime.now(),
          );
          await _localDataSource.savePendingOp(pendingOp);
        }
      } else {
        // Offline isek pending operation olarak işaretle
        final pendingOp = PendingOperationModel(
          id: _uuid.v4(),
          operation: OperationType.delete,
          noteId: noteId,
          createdAt: DateTime.now(),
        );
        await _localDataSource.savePendingOp(pendingOp);
        logInfo('💾 Offline delete pending operation kaydedildi: $noteId');
      }
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  @override
  Future<void> syncPending() async {
    if (!await _networkInfo.isConnected) return;

    try {
      final pendingOps = await _localDataSource.getPendingOps();

      for (final op in pendingOps) {
        try {
          switch (op.operation) {
            case OperationType.create:
              if (op.payload != null) {
                final noteModel = NoteModel.fromJson(op.payload!);
                await _remoteDataSource.createNoteRemote(noteModel);
              }
              break;
            case OperationType.update:
              if (op.payload != null) {
                final noteModel = NoteModel.fromJson(op.payload!);
                await _remoteDataSource.updateNoteRemote(noteModel);
              }
              break;
            case OperationType.delete:
              logInfo(
                '🔄 Pending delete operation sync ediliyor: ${op.noteId}',
              );
              await _remoteDataSource.deleteNoteRemote(op.noteId);
              logInfo('✅ Pending delete operation başarılı: ${op.noteId}');
              break;
          }
          // Başarılı olursa pending operation'ı sil
          await _localDataSource.removePendingOp(op.id);
        } catch (e) {
          // Hata olursa bu operation'ı atla, sonraki sefere tekrar dene
          continue;
        }
      }
    } catch (e) {
      throw Exception('Failed to sync pending operations: $e');
    }
  }

  @override
  Future<Either<Failure, NoteSummary>> summarizeNote(String content) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(
          NetworkFailure(message: 'İnternet bağlantısı gerekli'),
        );
      }

      final summaryModel = await _remoteDataSource.summarizeNote(content);
      final summary = summaryModel.toEntity();
      return Right(summary);
    } catch (e) {
      return Left(ServerFailure(message: 'Özetleme işlemi başarısız: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> extractTodos(String content) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(
          NetworkFailure(message: 'İnternet bağlantısı gerekli'),
        );
      }

      final todos = await _remoteDataSource.extractTodos(content);
      return Right(todos);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Yapılacak iş algılama başarısız: $e'),
      );
    }
  }
}
