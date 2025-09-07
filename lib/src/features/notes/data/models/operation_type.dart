import 'package:hive/hive.dart';

part 'operation_type.g.dart';

@HiveType(typeId: 2)
enum OperationType {
  @HiveField(0)
  create,
  @HiveField(1)
  update,
  @HiveField(2)
  delete,
}
