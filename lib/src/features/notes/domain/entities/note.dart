import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String ownerUid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool dirty;
  final bool deleted;
  final bool hasTodos;
  final List<String> todos;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.ownerUid,
    required this.createdAt,
    required this.updatedAt,
    this.dirty = false,
    this.deleted = false,
    this.hasTodos = false,
    this.todos = const [],
  });

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    ownerUid,
    createdAt,
    updatedAt,
    dirty,
    deleted,
    hasTodos,
    todos,
  ];

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? ownerUid,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? dirty,
    bool? deleted,
    bool? hasTodos,
    List<String>? todos,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      ownerUid: ownerUid ?? this.ownerUid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dirty: dirty ?? this.dirty,
      deleted: deleted ?? this.deleted,
      hasTodos: hasTodos ?? this.hasTodos,
      todos: todos ?? this.todos,
    );
  }
}
