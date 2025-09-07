import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/pending_operation.dart' as domain;
import 'operation_type.dart';

part 'pending_operation_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PendingOperationModel extends domain.PendingOperation {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final OperationType operation;

  @HiveField(2)
  @override
  final String noteId;

  @HiveField(3)
  @override
  final Map<String, dynamic>? payload;

  @HiveField(4)
  @override
  final DateTime createdAt;

  const PendingOperationModel({
    required this.id,
    required this.operation,
    required this.noteId,
    this.payload,
    required this.createdAt,
  }) : super(
         id: id,
         operation: operation,
         noteId: noteId,
         payload: payload,
         createdAt: createdAt,
       );

  factory PendingOperationModel.fromJson(Map<String, dynamic> json) =>
      _$PendingOperationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingOperationModelToJson(this);

  factory PendingOperationModel.fromEntity(domain.PendingOperation operation) {
    return PendingOperationModel(
      id: operation.id,
      operation: operation.operation,
      noteId: operation.noteId,
      payload: operation.payload,
      createdAt: operation.createdAt,
    );
  }

  domain.PendingOperation toEntity() {
    return domain.PendingOperation(
      id: id,
      operation: operation,
      noteId: noteId,
      payload: payload,
      createdAt: createdAt,
    );
  }
}
