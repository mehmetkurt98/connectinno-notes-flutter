import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart' as domain;

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends domain.User {
  const UserModel({
    required super.uid,
    required super.email,
    super.displayName,
    required super.emailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(domain.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      emailVerified: user.emailVerified,
    );
  }

  domain.User toEntity() {
    return domain.User(
      uid: uid,
      email: email,
      displayName: displayName,
      emailVerified: emailVerified,
    );
  }
}
