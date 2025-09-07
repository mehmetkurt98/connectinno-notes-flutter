// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_operation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingOperationModelAdapter extends TypeAdapter<PendingOperationModel> {
  @override
  final int typeId = 1;

  @override
  PendingOperationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingOperationModel(
      id: fields[0] as String,
      operation: fields[1] as OperationType,
      noteId: fields[2] as String,
      payload: (fields[3] as Map?)?.cast<String, dynamic>(),
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PendingOperationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.operation)
      ..writeByte(2)
      ..write(obj.noteId)
      ..writeByte(3)
      ..write(obj.payload)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingOperationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingOperationModel _$PendingOperationModelFromJson(
        Map<String, dynamic> json) =>
    PendingOperationModel(
      id: json['id'] as String,
      operation: $enumDecode(_$OperationTypeEnumMap, json['operation']),
      noteId: json['noteId'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PendingOperationModelToJson(
        PendingOperationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operation': _$OperationTypeEnumMap[instance.operation]!,
      'noteId': instance.noteId,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$OperationTypeEnumMap = {
  OperationType.create: 'create',
  OperationType.update: 'update',
  OperationType.delete: 'delete',
};
