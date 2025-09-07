import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/note.dart';
import '../cubit/notes_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';

class ModernNoteBottomSheet extends StatefulWidget {
  final NotesCubit notesCubit;
  final Note? existingNote;

  const ModernNoteBottomSheet({
    super.key,
    required this.notesCubit,
    this.existingNote,
  });

  @override
  State<ModernNoteBottomSheet> createState() => _ModernNoteBottomSheetState();
}

class _ModernNoteBottomSheetState extends State<ModernNoteBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();

    // Set existing note data if editing
    if (widget.existingNote != null) {
      _titleController.text = widget.existingNote!.title;
      _contentController.text = widget.existingNote!.content;
    }

    // Listen for changes to enable/disable save button
    _titleController.addListener(_checkForChanges);
    _contentController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    if (widget.existingNote != null) {
      final hasChanges =
          _titleController.text.trim() != widget.existingNote!.title ||
          _contentController.text.trim() != widget.existingNote!.content;

      if (hasChanges != _hasChanges) {
        setState(() {
          _hasChanges = hasChanges;
        });
      }
    } else {
      // Yeni not oluştururken de AI butonunun görünmesi için setState çağır
      setState(() {});
    }
  }

  @override
  void dispose() {
    _titleController.removeListener(_checkForChanges);
    _contentController.removeListener(_checkForChanges);
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _closeSheet() {
    Navigator.of(context).pop();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.notesCubit.submitNoteForm(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        existingNote: widget.existingNote,
      );

      // Close sheet after successful operation
      if (mounted) {
        widget.notesCubit.closeBottomSheet();
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Error handling is done in cubit with snackbar
      // Don't close sheet on error
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusXl),
          topRight: Radius.circular(AppSpacing.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppSpacing.shadowBlurRadius,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.heightMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: AppSpacing.handleBarWidth,
                  height: AppSpacing.handleBarHeight,
                  decoration: BoxDecoration(
                    color: AppColors.handleBar,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.handleBarRadius,
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.heightMd),

              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacing.iconButtonSize),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Icon(
                      widget.existingNote != null
                          ? Icons.edit_rounded
                          : Icons.add_rounded,
                      color: AppColors.textOnPrimary,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: AppSpacing.widthMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.existingNote != null
                              ? 'Edit Note'
                              : 'Create New Note',
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.heightXs),
                        Text(
                          widget.existingNote != null
                              ? 'Update your note content'
                              : 'Add a new note to your collection',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: _closeSheet,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.grey.shade600,
                            size: AppSpacing.iconSm,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.heightLg),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
                    Text(
                      'Title',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.heightSm),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: TextFormField(
                        controller: _titleController,
                        style: AppTextStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Enter note title...',
                          hintStyle: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(AppSpacing.heightMd),
                          prefixIcon: Icon(
                            Icons.title_rounded,
                            color: AppColors.primary,
                            size: AppSpacing.iconSm,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Lütfen bir başlık girin';
                          }
                          if (value.trim().length < 1) {
                            return 'Başlık en az 1 karakter olmalı';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    SizedBox(height: AppSpacing.heightLg),

                    // Content Field
                    Text(
                      'Content',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.heightSm),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: TextFormField(
                        controller: _contentController,
                        style: AppTextStyles.bodyLarge,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Write your note content here...',
                          hintStyle: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(AppSpacing.heightMd),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              top: AppSpacing.heightMd,
                              bottom: AppSpacing.heightMd,
                            ),
                            child: Icon(
                              Icons.notes_rounded,
                              color: AppColors.primary,
                              size: AppSpacing.iconSm,
                            ),
                          ),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Lütfen not içeriği girin';
                          }
                          if (value.trim().length < 1) {
                            return 'İçerik en az 1 karakter olmalı';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.heightLg),

              // Action Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _isLoading ? null : _closeSheet,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.heightMd,
                            ),
                            child: Text(
                              'Cancel',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: AppSpacing.widthMd),

                  // Save Button
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient:
                            _isLoading ||
                                    (widget.existingNote != null &&
                                        !_hasChanges)
                                ? LinearGradient(
                                  colors: [
                                    Colors.grey.shade300,
                                    Colors.grey.shade400,
                                  ],
                                )
                                : AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow:
                            _isLoading ||
                                    (widget.existingNote != null &&
                                        !_hasChanges)
                                ? null
                                : [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap:
                              _isLoading ||
                                      (widget.existingNote != null &&
                                          !_hasChanges)
                                  ? null
                                  : _submitForm,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.heightMd,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isLoading) ...[
                                  SizedBox(
                                    width: AppSpacing.iconSm,
                                    height: AppSpacing.iconSm,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppSpacing.widthSm),
                                ] else ...[
                                  Icon(
                                    widget.existingNote != null
                                        ? Icons.save_rounded
                                        : Icons.add_rounded,
                                    color: Colors.white,
                                    size: AppSpacing.iconSm,
                                  ),
                                  SizedBox(width: AppSpacing.widthSm),
                                ],
                                Text(
                                  _isLoading
                                      ? 'Saving...'
                                      : widget.existingNote != null
                                      ? 'Update Note'
                                      : 'Create Note',
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.heightMd),
            ],
          ),
        ),
      ),
    );
  }
}
