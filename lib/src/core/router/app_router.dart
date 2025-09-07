import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/notes/presentation/cubit/notes_cubit.dart';
import '../../features/notes/presentation/pages/notes_list_page.dart';
import '../../features/notes/domain/repositories/notes_repository.dart';
import '../di/injection_container.dart';

/// App router configuration using go_router
class AppRouter {
  static const String loginRoute = '/login';
  static const String notesRoute = '/notes';
  static const String homeRoute = '/';

  static final GoRouter _router = GoRouter(
    initialLocation: homeRoute,
    redirect: (context, state) {
      final authState = context.read<AuthCubit>().state;

      // Eğer login sayfasındaysak ve kullanıcı authenticated ise notes'a yönlendir
      if (state.uri.path == loginRoute && authState is AuthAuthenticated) {
        return notesRoute;
      }

      // Eğer notes sayfasındaysak ve kullanıcı authenticated değilse login'e yönlendir
      if (state.uri.path == notesRoute && authState is! AuthAuthenticated) {
        return loginRoute;
      }

      // Ana sayfa için yönlendirme
      if (state.uri.path == homeRoute) {
        if (authState is AuthAuthenticated) {
          return notesRoute;
        } else {
          return loginRoute;
        }
      }

      return null; // Yönlendirme yok
    },
    routes: [
      GoRoute(
        path: loginRoute,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: notesRoute,
        name: 'notes',
        builder: (context, state) {
          // AuthCubit'ten user bilgisini al
          final authState = context.read<AuthCubit>().state;
          if (authState is AuthAuthenticated) {
            return BlocProvider<NotesCubit>(
              create: (context) {
                final notesCubit = NotesCubit(
                  notesRepository: sl<NotesRepository>(),
                  currentUserUid: authState.user.uid,
                );
                notesCubit.setContext(context);
                return notesCubit;
              },
              child: const NotesListPage(),
            );
          } else {
            // Eğer authenticated değilse login'e yönlendir
            return const LoginPage();
          }
        },
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Sayfa bulunamadı',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Aradığınız sayfa mevcut değil: ${state.uri.path}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go(homeRoute),
                  child: const Text('Ana Sayfaya Dön'),
                ),
              ],
            ),
          ),
        ),
  );

  static GoRouter get router => _router;
}

/// Navigation helper class for easy navigation throughout the app
class AppNavigation {
  /// Navigate to login page
  static void goToLogin(BuildContext context) {
    context.go(AppRouter.loginRoute);
  }

  /// Navigate to notes page
  static void goToNotes(BuildContext context) {
    context.go(AppRouter.notesRoute);
  }

  /// Navigate to home (will redirect based on auth state)
  static void goToHome(BuildContext context) {
    context.go(AppRouter.homeRoute);
  }

  /// Push login page (for logout scenarios)
  static void pushLogin(BuildContext context) {
    context.pushReplacement(AppRouter.loginRoute);
  }

  /// Push notes page (for login scenarios)
  static void pushNotes(BuildContext context) {
    context.pushReplacement(AppRouter.notesRoute);
  }
}
