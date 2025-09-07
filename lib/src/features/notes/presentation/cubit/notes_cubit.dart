import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../../../../core/widgets/modern_snackbar.dart';
import '../../../../core/utils/logger_mixin.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> with LoggerMixin {
  final NotesRepository _notesRepository;
  final String _currentUserUid;
  final Uuid _uuid = const Uuid();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  BuildContext? _context;

  NotesCubit({
    required NotesRepository notesRepository,
    required String currentUserUid,
  }) : _notesRepository = notesRepository,
       _currentUserUid = currentUserUid,
       super(NotesInitial()) {
    initLogger();
    _initConnectivityListener();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void _initConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      // Online olduğunda otomatik sync yap
      if (results.any((result) => result != ConnectivityResult.none)) {
        syncNotes();
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  Future<void> loadNotes({bool forceRefresh = false}) async {
    // Eğer zaten notlar yüklenmişse ve force refresh değilse, loading gösterme
    if (!forceRefresh && state is NotesLoaded) {
      logInfo('📝 Notlar zaten yüklü, arka planda güncelleme yapılıyor...');
      // Arka planda güncelleme yap
      _refreshInBackground();
      return;
    }

    // Önce local cache'i kontrol et
    final cachedNotes = await _notesRepository.getCachedNotes(_currentUserUid);

    // Eğer cache'de not varsa loading göster, yoksa direkt empty state'e geç
    if (cachedNotes.isNotEmpty) {
      emit(NotesLoading());
    }

    try {
      logInfo('🔄 Notlar yükleniyor...');
      final notes = await _notesRepository.getAllNotes(_currentUserUid);
      logInfo('✅ ${notes.length} not yüklendi');

      // Cubit kapatılmışsa emit etme
      if (isClosed) return;

      emit(NotesLoaded(notes: notes));
    } catch (e) {
      logError('❌ Notlar yüklenirken hata: $e');

      // Cubit kapatılmışsa emit etme
      if (isClosed) return;

      emit(NotesError(message: e.toString()));
    }
  }

  /// Arka planda notları güncelle (UI'ı bloklamadan)
  Future<void> _refreshInBackground() async {
    if (state is! NotesLoaded) return;

    final currentState = state as NotesLoaded;

    try {
      // Cubit kapatılmışsa işlemi durdur
      if (isClosed) return;

      // Refreshing state'ini göster
      emit(currentState.copyWith(isRefreshing: true));

      // Repository'deki arka plan güncellemesi otomatik olarak çalışacak
      // Sadece local cache'den güncel notları al
      final notes = await _notesRepository.getAllNotes(_currentUserUid);

      // Cubit kapatılmışsa emit etme
      if (isClosed) return;

      // Sadece notlar değişmişse state'i güncelle
      if (currentState.notes.length != notes.length ||
          !_areNotesEqual(currentState.notes, notes)) {
        emit(NotesLoaded(notes: notes, isRefreshing: false));
        logInfo('🔄 Notlar arka planda güncellendi');
      } else {
        // Notlar aynıysa sadece refreshing state'ini kaldır
        emit(currentState.copyWith(isRefreshing: false));
      }
    } catch (e) {
      logWarning('⚠️ Arka plan güncellemesi başarısız: $e');

      // Cubit kapatılmışsa emit etme
      if (isClosed) return;

      // Hata durumunda refreshing state'ini kaldır
      emit(currentState.copyWith(isRefreshing: false));
    }
  }

  /// İki not listesinin eşit olup olmadığını kontrol et
  bool _areNotesEqual(List<Note> notes1, List<Note> notes2) {
    if (notes1.length != notes2.length) return false;

    for (int i = 0; i < notes1.length; i++) {
      if (notes1[i].id != notes2[i].id ||
          notes1[i].updatedAt != notes2[i].updatedAt) {
        return false;
      }
    }
    return true;
  }

  Future<void> addNote({required String title, required String content}) async {
    final note = Note(
      id: _uuid.v4(),
      title: title,
      content: content,
      ownerUid: _currentUserUid,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      // ÖNCE UI'ı güncelle (optimistic update)
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final newNotes = [...currentNotes, note];
        // En yeni notlar önce gelecek şekilde sırala
        newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        emit(NotesLoaded(notes: newNotes));
      }

      // Sonra backend'e gönder
      final createdNote = await _notesRepository.createNote(note);

      // Backend'den gelen gerçek not ile güncelle
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final index = currentNotes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          final newNotes = List<Note>.from(currentNotes);
          newNotes[index] = createdNote;
          // En yeni notlar önce gelecek şekilde sırala
          newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          emit(NotesLoaded(notes: newNotes));
        }
      }

      if (_context != null) {
        ModernSnackbar.success(
          _context!,
          message: 'Note created successfully!',
          title: 'Note Added',
        );
      }
    } catch (e) {
      // Hata durumunda optimistic update'i geri al
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final newNotes = currentNotes.where((n) => n.id != note.id).toList();
        emit(NotesLoaded(notes: newNotes));
      }
      emit(NotesError(message: e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: 'Failed to create note. Please try again.',
          title: 'Create Failed',
        );
      }
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final updatedNote = note.copyWith(updatedAt: DateTime.now());

      // ÖNCE UI'ı güncelle (optimistic update)
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final index = currentNotes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          final newNotes = List<Note>.from(currentNotes);
          newNotes[index] = updatedNote;
          // En yeni notlar önce gelecek şekilde sırala
          newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          emit(NotesLoaded(notes: newNotes));
        }
      }

      // Sonra backend'e gönder
      final backendUpdatedNote = await _notesRepository.updateNote(updatedNote);

      // Backend'den gelen gerçek not ile güncelle
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final index = currentNotes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          final newNotes = List<Note>.from(currentNotes);
          newNotes[index] = backendUpdatedNote;
          // En yeni notlar önce gelecek şekilde sırala
          newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          emit(NotesLoaded(notes: newNotes));
        }
      }

      if (_context != null) {
        ModernSnackbar.success(
          _context!,
          message: 'Note updated successfully!',
          title: 'Note Updated',
        );
      }
    } catch (e) {
      // Hata durumunda optimistic update'i geri al
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final index = currentNotes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          final newNotes = List<Note>.from(currentNotes);
          newNotes[index] = note; // Orijinal notu geri koy
          emit(NotesLoaded(notes: newNotes));
        }
      }
      emit(NotesError(message: e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: 'Failed to update note. Please try again.',
          title: 'Update Failed',
        );
      }
    }
  }

  Future<void> deleteNote(String noteId) async {
    // Silinecek notu sakla (hata durumunda geri koymak için)
    Note? deletedNote;
    if (state is NotesLoaded) {
      final currentNotes = (state as NotesLoaded).notes;
      try {
        deletedNote = currentNotes.firstWhere((note) => note.id == noteId);
      } catch (e) {
        deletedNote = null;
      }
    }

    try {
      // ÖNCE UI'dan sil (optimistic update)
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        final newNotes =
            currentNotes.where((note) => note.id != noteId).toList();
        emit(NotesLoaded(notes: newNotes));
      }

      // Sonra backend'e gönder
      await _notesRepository.deleteNote(noteId);

      if (_context != null) {
        ModernSnackbar.success(
          _context!,
          message: 'Note deleted successfully!',
          title: 'Note Deleted',
        );
      }
    } catch (e) {
      // Hata durumunda optimistic update'i geri al
      if (state is NotesLoaded && deletedNote != null) {
        final currentNotes = (state as NotesLoaded).notes;
        final newNotes = [...currentNotes, deletedNote];
        // En yeni notlar önce gelecek şekilde sırala
        newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        emit(NotesLoaded(notes: newNotes));
      }
      emit(NotesError(message: e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: 'Failed to delete note. Please try again.',
          title: 'Delete Failed',
        );
      }
    }
  }

  Future<void> syncNotes() async {
    try {
      logInfo('🔄 Senkronizasyon başlatılıyor...');
      await _notesRepository.syncPending();
      logInfo('✅ Senkronizasyon tamamlandı');
      // Sync sonrası notları yeniden yükle (force refresh ile)
      await loadNotes(forceRefresh: true);

      // Sync complete notification removed for better UX
      // if (_context != null) {
      //   ModernSnackbar.success(
      //     _context!,
      //     message: 'All notes have been synchronized successfully!',
      //     title: 'Sync Complete',
      //   );
      // }
    } catch (e) {
      logError('❌ Senkronizasyon hatası: $e');

      // Cubit kapatılmışsa emit etme
      if (isClosed) return;

      emit(NotesError(message: e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: 'Failed to sync notes. Please check your connection.',
          title: 'Sync Failed',
        );
      }
    }
  }

  // Bottom Sheet Logic
  void openAddNoteBottomSheet() {
    emit(NotesShowAddBottomSheet());
  }

  void openEditNoteBottomSheet(Note note) {
    emit(NotesShowEditBottomSheet(note: note));
  }

  void closeBottomSheet() {
    if (state is NotesShowAddBottomSheet || state is NotesShowEditBottomSheet) {
      loadNotes(); // Refresh notes when closing
    }
  }

  // Form submission logic - Direct backend call without optimistic updates
  Future<void> submitNoteForm({
    required String title,
    required String content,
    Note? existingNote,
  }) async {
    try {
      if (existingNote != null) {
        // Update existing note - direct backend call
        final updatedNote = existingNote.copyWith(
          title: title,
          content: content,
          updatedAt: DateTime.now(),
        );
        final backendUpdatedNote = await _notesRepository.updateNote(
          updatedNote,
        );

        // Show success snackbar for update
        if (_context != null) {
          ModernSnackbar.success(
            _context!,
            message: 'Note updated successfully!',
            title: 'Note Updated',
          );
        }

        // UI'ı güncelle - update işlemi için
        if (state is NotesLoaded) {
          final currentNotes = (state as NotesLoaded).notes;
          final index = currentNotes.indexWhere((n) => n.id == existingNote.id);
          if (index != -1) {
            final newNotes = List<Note>.from(currentNotes);
            newNotes[index] = backendUpdatedNote;
            // En yeni notlar önce gelecek şekilde sırala
            newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
            emit(NotesLoaded(notes: newNotes));
            logInfo('✅ UI güncellendi, not başarıyla düzenlendi');
          }
        }
      } else {
        // Create new note - direct backend call
        final note = Note(
          id: _uuid.v4(),
          title: title,
          content: content,
          ownerUid: _currentUserUid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // Geçici olarak AI extraction'ı devre dışı bırak, sadece normal not kaydet
        logInfo('📝 Normal not kaydediliyor (AI extraction devre dışı)');
        final createdNote = await _notesRepository.createNote(note);

        // Show success snackbar for create
        if (_context != null) {
          ModernSnackbar.success(
            _context!,
            message: 'Note created successfully!',
            title: 'Note Added',
          );
        }

        // UI'ı güncelle - create işlemi için
        if (state is NotesLoaded) {
          final currentNotes = (state as NotesLoaded).notes;
          final newNotes = [...currentNotes, createdNote];
          // En yeni notlar önce gelecek şekilde sırala
          newNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          emit(NotesLoaded(notes: newNotes));
          logInfo('✅ UI güncellendi, toplam not sayısı: ${newNotes.length}');
        }
      }
    } catch (e) {
      // Show error snackbar
      if (_context != null) {
        final action = existingNote != null ? 'update' : 'create';
        ModernSnackbar.error(
          _context!,
          message: 'Failed to $action note. Please try again.',
          title: '${action == 'update' ? 'Update' : 'Create'} Failed',
        );
      }
      rethrow; // Re-throw to let the UI handle the error state
    }
  }

  /// Extract todos from note content using AI
  Future<List<String>> extractTodos(String content) async {
    try {
      final result = await _notesRepository.extractTodos(content);
      return result.fold((failure) {
        if (_context != null) {
          ModernSnackbar.error(
            _context!,
            message: failure.message,
            title: 'AI Todo Extraction Failed',
          );
        }
        return [];
      }, (todos) => todos);
    } catch (e) {
      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: 'Failed to extract todos: $e',
          title: 'Todo Extraction Error',
        );
      }
      return [];
    }
  }
}
