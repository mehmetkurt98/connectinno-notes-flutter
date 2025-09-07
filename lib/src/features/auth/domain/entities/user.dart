import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final bool emailVerified;

  const User({
    required this.uid,
    required this.email,
    this.displayName,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [uid, email, displayName, emailVerified];

  User copyWith({
    String? uid,
    String? email,
    String? displayName,
    bool? emailVerified,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }
}
