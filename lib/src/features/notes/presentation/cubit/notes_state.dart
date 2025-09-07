part of 'notes_cubit.dart';

sealed class NotesState {
  const NotesState();
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  final bool isRefreshing; // Arka plan güncelleme durumu

  const NotesLoaded({required this.notes, this.isRefreshing = false});

  NotesLoaded copyWith({List<Note>? notes, bool? isRefreshing}) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

class NotesError extends NotesState {
  final String message;

  const NotesError({required this.message});
}

class NotesShowAddBottomSheet extends NotesState {}

class NotesShowEditBottomSheet extends NotesState {
  final Note note;

  const NotesShowEditBottomSheet({required this.note});
}
