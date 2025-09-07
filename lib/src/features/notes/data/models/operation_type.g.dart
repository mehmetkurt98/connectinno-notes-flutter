// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationTypeAdapter extends TypeAdapter<OperationType> {
  @override
  final int typeId = 2;

  @override
  OperationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OperationType.create;
      case 1:
        return OperationType.update;
      case 2:
        return OperationType.delete;
      default:
        return OperationType.create;
    }
  }

  @override
  void write(BinaryWriter writer, OperationType obj) {
    switch (obj) {
      case OperationType.create:
        writer.writeByte(0);
        break;
      case OperationType.update:
        writer.writeByte(1);
        break;
      case OperationType.delete:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
