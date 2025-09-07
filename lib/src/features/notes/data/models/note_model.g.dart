// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      ownerUid: fields[3] as String,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
      dirty: fields[6] as bool,
      deleted: fields[7] as bool,
      hasTodos: fields[8] as bool,
      todos: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.ownerUid)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.dirty)
      ..writeByte(7)
      ..write(obj.deleted)
      ..writeByte(8)
      ..write(obj.hasTodos)
      ..writeByte(9)
      ..write(obj.todos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      ownerUid: json['owner_uid'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      dirty: json['dirty'] as bool? ?? false,
      deleted: json['deleted'] as bool? ?? false,
      hasTodos: json['hasTodos'] as bool? ?? false,
      todos:
          (json['todos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'owner_uid': instance.ownerUid,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'dirty': instance.dirty,
      'deleted': instance.deleted,
      'hasTodos': instance.hasTodos,
      'todos': instance.todos,
    };
