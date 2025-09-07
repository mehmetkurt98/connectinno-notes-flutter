import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/note.dart' as domain;

part 'note_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class NoteModel extends domain.Note {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String content;

  @HiveField(3)
  @JsonKey(name: 'owner_uid')
  @override
  final String ownerUid;

  @HiveField(4)
  @JsonKey(name: 'created_at')
  @override
  final DateTime createdAt;

  @HiveField(5)
  @JsonKey(name: 'updated_at')
  @override
  final DateTime updatedAt;

  @HiveField(6)
  @override
  final bool dirty;

  @HiveField(7)
  @override
  final bool deleted;

  @HiveField(8)
  @override
  final bool hasTodos;

  @HiveField(9)
  @override
  final List<String> todos;

  const NoteModel({
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
  }) : super(
         id: id,
         title: title,
         content: content,
         ownerUid: ownerUid,
         createdAt: createdAt,
         updatedAt: updatedAt,
         dirty: dirty,
         deleted: deleted,
         hasTodos: hasTodos,
         todos: todos,
       );

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  factory NoteModel.fromEntity(domain.Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      ownerUid: note.ownerUid,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      dirty: note.dirty,
      deleted: note.deleted,
      hasTodos: note.hasTodos,
      todos: note.todos,
    );
  }

  domain.Note toEntity() {
    return domain.Note(
      id: id,
      title: title,
      content: content,
      ownerUid: ownerUid,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dirty: dirty,
      deleted: deleted,
      hasTodos: hasTodos,
      todos: todos,
    );
  }

  /// Boş bir NoteModel döndür (karşılaştırma için)
  static NoteModel empty() {
    return NoteModel(
      id: '',
      title: '',
      content: '',
      ownerUid: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
