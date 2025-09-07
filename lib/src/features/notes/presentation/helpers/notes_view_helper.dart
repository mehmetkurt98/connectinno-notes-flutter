import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../widgets/modern_note_bottom_sheet.dart';
import '../widgets/ai_summary_dialog.dart';
import '../../domain/entities/note.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';

/// Helper class for Notes view operations
/// Separates view logic from UI components following Clean Architecture
class NotesViewHelper {
  /// Show add note bottom sheet
  static void showAddNoteBottomSheet(BuildContext context) {
    final notesCubit = context.read<NotesCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => ModernNoteBottomSheet(notesCubit: notesCubit),
    );
  }

  /// Show edit note bottom sheet
  static void showEditNoteBottomSheet(BuildContext context, Note note) {
    final notesCubit = context.read<NotesCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder:
          (context) =>
              ModernNoteBottomSheet(existingNote: note, notesCubit: notesCubit),
    );
  }

  /// Show delete confirmation dialog
  static void showDeleteDialog(BuildContext context, String noteId) {
    final notesCubit = context.read<NotesCubit>();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: AppSpacing.iconSm,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                const Text('Delete Note'),
              ],
            ),
            content: const Text(
              'Are you sure you want to delete this note? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  color: AppColors.error,
                ),
                child: TextButton(
                  onPressed: () {
                    notesCubit.deleteNote(noteId);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Delete',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  /// Handle refresh action
  static Future<void> handleRefresh(BuildContext context) async {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<NotesCubit>().loadNotes(forceRefresh: true);
    }
  }

  /// Handle retry action for error state
  static void handleRetry(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<NotesCubit>().loadNotes();
    }
  }

  /// Handle sync action
  static void handleSync(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<NotesCubit>().syncNotes();
    }
  }

  /// Handle logout action
  static void handleLogout(BuildContext context) {
    context.read<AuthCubit>().signOut();
  }

  /// Initialize notes loading on page load
  static void initializeNotesLoading(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthAuthenticated) {
        context.read<NotesCubit>().loadNotes();
      }
    });
  }

  /// Show AI summary dialog
  static void showAISummaryDialog(BuildContext context, String content) {
    if (content.trim().length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Özetleme için en az 5 karakter gerekli'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AISummaryDialog(content: content),
    );
  }

  /// Format date for display
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
