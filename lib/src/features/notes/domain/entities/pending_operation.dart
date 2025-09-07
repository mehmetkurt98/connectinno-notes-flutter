import 'package:equatable/equatable.dart';
import '../../data/models/operation_type.dart';

class PendingOperation extends Equatable {
  final String id;
  final OperationType operation;
  final String noteId;
  final Map<String, dynamic>? payload;
  final DateTime createdAt;

  const PendingOperation({
    required this.id,
    required this.operation,
    required this.noteId,
    this.payload,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, operation, noteId, payload, createdAt];

  PendingOperation copyWith({
    String? id,
    OperationType? operation,
    String? noteId,
    Map<String, dynamic>? payload,
    DateTime? createdAt,
  }) {
    return PendingOperation(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      noteId: noteId ?? this.noteId,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
