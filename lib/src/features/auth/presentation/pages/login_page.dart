import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/auth_form.dart';
import '../helpers/auth_view_helper.dart';
import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;

  @override
  void initState() {
    super.initState();
    // AuthCubit'e context'i set et
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().setContext(context);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    AuthViewHelper.submitForm(
      context: context,
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      isSignUp: _isSignUp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Kullanıcı başarıyla giriş yaptı, notes sayfasına yönlendir
          AppNavigation.goToNotes(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo/Title
                Icon(
                  Icons.note_alt,
                  size: AppSpacing.xl3,
                  color: AppColors.primary,
                ),
                SizedBox(height: AppSpacing.heightMd),
                Text(
                  'Connectinno Notes',
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.heightSm),
                Text(
                  _isSignUp ? 'Create your account' : 'Welcome back',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.lg2),

                // Auth Form
                AuthForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isSignUp: _isSignUp,
                  onSubmit: _submitForm,
                ),

                SizedBox(height: AppSpacing.md),

                // Toggle Sign Up/Sign In
                TextButton(
                  onPressed: () {
                    AuthViewHelper.toggleAuthMode(
                      context: context,
                      currentIsSignUp: _isSignUp,
                      onToggle: (newValue) {
                        setState(() {
                          _isSignUp = newValue;
                        });
                      },
                    );
                  },
                  child: Text(
                    _isSignUp
                        ? 'Already have an account? Sign In'
                        : 'Don\'t have an account? Sign Up',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.heightMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
