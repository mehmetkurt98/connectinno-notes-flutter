import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

/// Helper class for Auth view operations
/// Separates view logic from UI components following Clean Architecture
class AuthViewHelper {
  /// Handle form submission for login/signup
  static void submitForm({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required bool isSignUp,
  }) {
    if (formKey.currentState!.validate()) {
      if (isSignUp) {
        context.read<AuthCubit>().signUpWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      } else {
        context.read<AuthCubit>().signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      }
    }
  }

  /// Toggle between sign up and sign in modes
  static void toggleAuthMode({
    required BuildContext context,
    required bool currentIsSignUp,
    required Function(bool) onToggle,
  }) {
    onToggle(!currentIsSignUp);
  }
}
