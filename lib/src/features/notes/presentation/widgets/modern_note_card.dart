import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/note.dart';
import '../helpers/notes_view_helper.dart';

class ModernNoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onAISummary;

  const ModernNoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onAISummary,
  });

  @override
  State<ModernNoteCard> createState() => _ModernNoteCardState();
}

class _ModernNoteCardState extends State<ModernNoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isExpanded = false;
  bool _isTodosExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: AppSpacing.animationDuration),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _elevationAnimation = Tween<double>(begin: 4.0, end: 8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getPreviewContent(String content) {
    if (_isExpanded) return content;

    // İlk 2 cümleyi al
    final sentences = content.split(RegExp(r'[.!?]+'));
    if (sentences.length <= AppSpacing.maxPreviewSentences) return content;

    return '${sentences.take(AppSpacing.maxPreviewSentences).join('.')}...';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) {
              _animationController.reverse();
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            onTapCancel: () => _animationController.reverse(),
            child: Container(
              margin: EdgeInsets.only(bottom: AppSpacing.heightMd),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.surface, AppColors.surfaceVariant],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: AppSpacing.shadowBlurRadius,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: AppColors.surface.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.grey.shade50.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.heightMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with title and menu
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.note.title,
                                style: AppTextStyles.headlineSmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                  height: 1.2,
                                ),
                                maxLines: AppSpacing.maxTitleLines,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: AppSpacing.widthSm),
                            _buildMenuButton(),
                          ],
                        ),
                        SizedBox(height: AppSpacing.heightSm),

                        // Content
                        Text(
                          _getPreviewContent(widget.note.content),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          maxLines:
                              _isExpanded ? null : AppSpacing.maxPreviewLines,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        ),

                        // Expand/Collapse indicator
                        if (widget.note.content.length >
                            AppSpacing.contentPreviewThreshold) ...[
                          SizedBox(height: AppSpacing.heightXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: AppColors.textSecondary,
                                size: AppSpacing.expandIconSize,
                              ),
                              SizedBox(width: AppSpacing.widthXs),
                              Text(
                                _isExpanded ? 'Daha az göster' : 'Devamını oku',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],

                        // Todos Section
                        if (widget.note.hasTodos &&
                            widget.note.todos.isNotEmpty) ...[
                          SizedBox(height: AppSpacing.heightSm),
                          Container(
                            padding: EdgeInsets.all(AppSpacing.heightSm),
                            decoration: BoxDecoration(
                              color: AppColors.todoBackground,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSm,
                              ),
                              border: Border.all(
                                color: AppColors.todoBorder,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.checklist_rounded,
                                      color: AppColors.todoIcon,
                                      size: AppSpacing.iconXs,
                                    ),
                                    SizedBox(width: AppSpacing.widthXs),
                                    Text(
                                      'Yapılacaklar',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.todoText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSpacing.heightXs),
                                ...widget.note.todos
                                    .take(
                                      _isTodosExpanded
                                          ? widget.note.todos.length
                                          : AppSpacing.maxPreviewTodos,
                                    )
                                    .map((todo) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: AppSpacing.heightXs,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: AppSpacing.todoBulletSize,
                                              height: AppSpacing.todoBulletSize,
                                              margin: EdgeInsets.only(
                                                top: 6,
                                                right: AppSpacing.widthXs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.todoBullet,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                todo,
                                                style: AppTextStyles.bodySmall
                                                    .copyWith(
                                                      color: AppColors.todoText,
                                                      fontSize:
                                                          AppSpacing
                                                              .todoTextSize,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                    .toList(),
                                if (widget.note.todos.length >
                                    AppSpacing.maxPreviewTodos) ...[
                                  SizedBox(height: AppSpacing.heightXs),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isTodosExpanded = !_isTodosExpanded;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _isTodosExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: AppColors.todoIcon,
                                          size: AppSpacing.todoExpandIconSize,
                                        ),
                                        SizedBox(width: AppSpacing.widthXs),
                                        Text(
                                          _isTodosExpanded
                                              ? 'Daha az göster'
                                              : '+${widget.note.todos.length - AppSpacing.maxPreviewTodos} daha...',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                                color: AppColors.todoIcon,
                                                fontSize:
                                                    AppSpacing
                                                        .todoExpandTextSize,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],

                        SizedBox(height: AppSpacing.heightMd),

                        // Footer with date and gradient line
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary.withOpacity(0.3),
                                      AppColors.primary.withOpacity(0.1),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacing.widthSm),
                            Text(
                              NotesViewHelper.formatDate(widget.note.updatedAt),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textHint,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: AppColors.iconPrimary,
          size: AppSpacing.iconSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        elevation: 8,
        itemBuilder:
            (context) => [
              PopupMenuItem(
                value: 'ai_summary',
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.purple,
                      size: 18,
                    ),
                    SizedBox(width: AppSpacing.widthSm),
                    Text('AI Özetle', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: AppColors.primary, size: 18),
                    SizedBox(width: AppSpacing.widthSm),
                    Text('Edit', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: AppColors.error, size: 18),
                    SizedBox(width: AppSpacing.widthSm),
                    Text('Delete', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
            ],
        onSelected: (value) {
          if (value == 'ai_summary') {
            widget.onAISummary();
          } else if (value == 'edit') {
            widget.onEdit();
          } else if (value == 'delete') {
            widget.onDelete();
          }
        },
      ),
    );
  }
}
