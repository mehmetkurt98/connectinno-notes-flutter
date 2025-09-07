import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';
import '../cubit/auth_cubit.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isSignUp;
  final VoidCallback onSubmit;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isSignUp,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                size: AppSpacing.iconSm,
                color: AppColors.iconPrimary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide: BorderSide(color: AppColors.borderFocus),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide: BorderSide(color: AppColors.borderError),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.heightMd,
                vertical: AppSpacing.heightSm,
              ),
            ),
            style: AppTextStyles.bodyLarge,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!EmailValidator.isValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.heightMd),

          // Password Field
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.lock,
                size: AppSpacing.iconSm,
                color: AppColors.iconPrimary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide: BorderSide(color: AppColors.borderFocus),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                borderSide: BorderSide(color: AppColors.borderError),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.heightMd,
                vertical: AppSpacing.heightSm,
              ),
            ),
            style: AppTextStyles.bodyLarge,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (!PasswordValidator.isValid(value)) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.md),

          // Submit Button
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeightLg,
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.textOnPrimary,
                    disabledBackgroundColor: AppColors.buttonDisabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    elevation: 2,
                  ),
                  child:
                      state is AuthLoading
                          ? SizedBox(
                            height: AppSpacing.iconSm,
                            width: AppSpacing.iconSm,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.textOnPrimary,
                              ),
                            ),
                          )
                          : Text(
                            isSignUp ? 'Sign Up' : 'Sign In',
                            style: AppTextStyles.buttonLarge,
                          ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
