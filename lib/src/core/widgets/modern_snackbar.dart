import 'package:flutter/material.dart';
import '../utils/notification_type.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_spacing.dart';

class ModernSnackbar {
  /// Show a modern snackbar with custom styling
  static void show(
    BuildContext context, {
    required String message,
    required NotificationType type,
    String? title,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder:
          (context) => _ModernSnackbarWidget(
            message: message,
            type: type,
            title: title,
            duration: duration,
            onAction: onAction,
            actionLabel: actionLabel,
            onDismiss: () => overlayEntry.remove(),
          ),
    );

    overlay.insert(overlayEntry);

    // Auto dismiss after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  /// Show success snackbar
  static void success(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: NotificationType.success,
      title: title,
      duration: duration,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  /// Show error snackbar
  static void error(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 5),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: NotificationType.error,
      title: title,
      duration: duration,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  /// Show warning snackbar
  static void warning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: NotificationType.warning,
      title: title,
      duration: duration,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  /// Show info snackbar
  static void info(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: NotificationType.info,
      title: title,
      duration: duration,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }
}

class _ModernSnackbarWidget extends StatefulWidget {
  final String message;
  final NotificationType type;
  final String? title;
  final Duration duration;
  final VoidCallback? onAction;
  final String? actionLabel;
  final VoidCallback onDismiss;

  const _ModernSnackbarWidget({
    required this.message,
    required this.type,
    this.title,
    required this.duration,
    this.onAction,
    this.actionLabel,
    required this.onDismiss,
  });

  @override
  State<_ModernSnackbarWidget> createState() => _ModernSnackbarWidgetState();
}

class _ModernSnackbarWidgetState extends State<_ModernSnackbarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: widget.type.color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        widget.type.backgroundColor.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.heightMd),
                    child: Row(
                      children: [
                        // Icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: widget.type.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: widget.type.color.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            widget.type.icon,
                            color: widget.type.color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: AppSpacing.widthMd),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Title
                              if (widget.title != null) ...[
                                Text(
                                  widget.title!,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: widget.type.color,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.heightXs),
                              ],

                              // Message
                              Text(
                                widget.message,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.grey.shade700,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Action Button
                        if (widget.onAction != null &&
                            widget.actionLabel != null) ...[
                          SizedBox(width: AppSpacing.widthSm),
                          Container(
                            decoration: BoxDecoration(
                              color: widget.type.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  widget.onAction!();
                                  _dismiss();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.widthMd,
                                    vertical: AppSpacing.heightSm,
                                  ),
                                  child: Text(
                                    widget.actionLabel!,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],

                        // Close Button
                        SizedBox(width: AppSpacing.widthSm),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: _dismiss,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.grey.shade600,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
