import 'package:flutter/material.dart';

/// Notification types for different message categories
enum NotificationType { success, error, warning, info }

/// Extension to get colors and icons for notification types
extension NotificationTypeExtension on NotificationType {
  /// Get the primary color for this notification type
  Color get color {
    switch (this) {
      case NotificationType.success:
        return const Color(0xFF4CAF50); // Green
      case NotificationType.error:
        return const Color(0xFFF44336); // Red
      case NotificationType.warning:
        return const Color(0xFFFF9800); // Orange
      case NotificationType.info:
        return const Color(0xFF2196F3); // Blue
    }
  }

  /// Get the light background color for this notification type
  Color get backgroundColor {
    switch (this) {
      case NotificationType.success:
        return const Color(0xFFE8F5E8); // Light Green
      case NotificationType.error:
        return const Color(0xFFFFEBEE); // Light Red
      case NotificationType.warning:
        return const Color(0xFFFFF3E0); // Light Orange
      case NotificationType.info:
        return const Color(0xFFE3F2FD); // Light Blue
    }
  }

  /// Get the icon for this notification type
  IconData get icon {
    switch (this) {
      case NotificationType.success:
        return Icons.check_circle_rounded;
      case NotificationType.error:
        return Icons.error_rounded;
      case NotificationType.warning:
        return Icons.warning_rounded;
      case NotificationType.info:
        return Icons.info_rounded;
    }
  }

  /// Get the title for this notification type
  String get title {
    switch (this) {
      case NotificationType.success:
        return 'Success';
      case NotificationType.error:
        return 'Error';
      case NotificationType.warning:
        return 'Warning';
      case NotificationType.info:
        return 'Info';
    }
  }
}
