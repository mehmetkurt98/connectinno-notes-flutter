import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/widgets/modern_snackbar.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  BuildContext? _context;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    _init();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void _init() {
    // Listen to auth state changes
    _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));

      if (_context != null) {
        ModernSnackbar.success(
          _context!,
          message: 'Welcome back! You have successfully signed in.',
          title: 'Login Successful',
        );
      }
    } catch (e) {
      emit(AuthError(e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: _getErrorMessage(e.toString()),
          title: 'Login Failed',
        );
      }
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));

      if (_context != null) {
        ModernSnackbar.success(
          _context!,
          message:
              'Account created successfully! Welcome to Connectinno Notes.',
          title: 'Registration Successful',
        );
      }
    } catch (e) {
      emit(AuthError(e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: _getErrorMessage(e.toString()),
          title: 'Registration Failed',
        );
      }
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthUnauthenticated());

      if (_context != null) {
        ModernSnackbar.info(
          _context!,
          message: 'You have been signed out successfully.',
          title: 'Signed Out',
        );
      }
    } catch (e) {
      emit(AuthError(e.toString()));

      if (_context != null) {
        ModernSnackbar.error(
          _context!,
          message: 'Failed to sign out. Please try again.',
          title: 'Sign Out Failed',
        );
      }
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Convert Firebase error messages to user-friendly messages
  String _getErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'No account found with this email address.';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (error.contains('email-already-in-use')) {
      return 'An account already exists with this email address.';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak. Please choose a stronger password.';
    } else if (error.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection.';
    } else if (error.contains('too-many-requests')) {
      return 'Too many failed attempts. Please try again later.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
