import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/router/app_router.dart';
import '../cubit/notes_cubit.dart';
import '../widgets/modern_note_card.dart';
import '../widgets/modern_fab.dart';
import '../widgets/modern_empty_state.dart';
import '../helpers/notes_view_helper.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  @override
  void initState() {
    super.initState();
    // AuthCubit'e context'i set et
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().setContext(context);
    });
    // Initialize notes loading through helper
    NotesViewHelper.initializeNotesLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Kullanıcı çıkış yaptı, login sayfasına yönlendir
          AppNavigation.pushLogin(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'My Notes',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: AppSpacing.widthSm),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: IconButton(
                onPressed: () => NotesViewHelper.handleSync(context),
                icon: const Icon(
                  Icons.sync_rounded,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: AppSpacing.widthMd),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: IconButton(
                onPressed: () => NotesViewHelper.handleLogout(context),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ],
        ),
        body: BlocListener<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NotesShowAddBottomSheet) {
              NotesViewHelper.showAddNoteBottomSheet(context);
            } else if (state is NotesShowEditBottomSheet) {
              NotesViewHelper.showEditNoteBottomSheet(context, state.note);
            }
          },
          child: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSpacing.loadingIndicatorSize,
                        height: AppSpacing.loadingIndicatorSize,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.loadingIndicatorRadius,
                          ),
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ),
                      SizedBox(height: AppSpacing.heightMd),
                      Text(
                        'Notlarınız yükleniyor...',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is NotesError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.heightXl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: AppSpacing.xl3,
                          height: AppSpacing.xl3,
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.xl3 / 2,
                            ),
                          ),
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: AppSpacing.iconXl,
                            color: AppColors.error,
                          ),
                        ),
                        SizedBox(height: AppSpacing.heightLg),
                        Text(
                          'Oops! Something went wrong',
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppSpacing.heightSm),
                        Text(
                          state.message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSpacing.heightLg),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: AppColors.primaryGradient,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => NotesViewHelper.handleRetry(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.widthLg,
                                  vertical: AppSpacing.heightMd,
                                ),
                                child: Text(
                                  'Try Again',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is NotesLoaded) {
                if (state.notes.isEmpty) {
                  return ModernEmptyState(
                    onAddNote:
                        () => NotesViewHelper.showAddNoteBottomSheet(context),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => NotesViewHelper.handleRefresh(context),
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  child: ListView.builder(
                    padding: EdgeInsets.all(AppSpacing.heightMd),
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      return ModernNoteCard(
                        note: note,
                        onTap:
                            () => NotesViewHelper.showEditNoteBottomSheet(
                              context,
                              note,
                            ),
                        onEdit:
                            () => NotesViewHelper.showEditNoteBottomSheet(
                              context,
                              note,
                            ),
                        onDelete:
                            () => NotesViewHelper.showDeleteDialog(
                              context,
                              note.id,
                            ),
                        onAISummary:
                            () => NotesViewHelper.showAISummaryDialog(
                              context,
                              note.content,
                            ),
                      );
                    },
                  ),
                );
              }

              return Center(
                child: Text(
                  'Başlatılıyor...',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.cardBackground,
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: ModernFAB(
          onPressed: () => NotesViewHelper.showAddNoteBottomSheet(context),
        ),
      ),
    );
  }
}
