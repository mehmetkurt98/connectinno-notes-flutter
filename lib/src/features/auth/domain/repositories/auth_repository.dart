import '../entities/user.dart';

abstract class AuthRepository {
  /// Get current user
  Future<User?> getCurrentUser();

  /// Sign in with email and password
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out
  Future<void> signOut();

  /// Listen to auth state changes
  Stream<User?> get authStateChanges;
}
