import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Application spacing constants
class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // Web için responsive scaling faktörü
  static double get _webScaleFactor => kIsWeb ? 0.8 : 1.0;

  // Extra Small Spacing
  static double get xs => (4.0.w * _webScaleFactor).clamp(4.0, 12.0);
  static double get xs2 => (6.0.w * _webScaleFactor).clamp(6.0, 16.0);
  static double get xs3 => (8.0.w * _webScaleFactor).clamp(8.0, 20.0);

  // Small Spacing
  static double get sm => (12.0.w * _webScaleFactor).clamp(12.0, 24.0);
  static double get sm2 => (16.0.w * _webScaleFactor).clamp(16.0, 32.0);
  static double get sm3 => (20.0.w * _webScaleFactor).clamp(20.0, 40.0);

  // Medium Spacing
  static double get md => (24.0.w * _webScaleFactor).clamp(24.0, 48.0);
  static double get md2 => (28.0.w * _webScaleFactor).clamp(28.0, 56.0);
  static double get md3 => (32.0.w * _webScaleFactor).clamp(32.0, 64.0);

  // Large Spacing
  static double get lg => (40.0.w * _webScaleFactor).clamp(40.0, 80.0);
  static double get lg2 => (48.0.w * _webScaleFactor).clamp(48.0, 96.0);
  static double get lg3 => (56.0.w * _webScaleFactor).clamp(56.0, 112.0);

  // Extra Large Spacing
  static double get xl => (64.0.w * _webScaleFactor).clamp(64.0, 128.0);
  static double get xl2 => (80.0.w * _webScaleFactor).clamp(80.0, 160.0);
  static double get xl3 => (96.0.w * _webScaleFactor).clamp(96.0, 192.0);

  // Height Spacing
  static double get heightXs => (4.0.h * _webScaleFactor).clamp(4.0, 12.0);
  static double get heightSm => (8.0.h * _webScaleFactor).clamp(8.0, 16.0);
  static double get heightMd => (16.0.h * _webScaleFactor).clamp(16.0, 32.0);
  static double get heightLg => (24.0.h * _webScaleFactor).clamp(24.0, 48.0);
  static double get heightXl => (32.0.h * _webScaleFactor).clamp(32.0, 64.0);

  // Width Spacing
  static double get widthXs => (4.0.w * _webScaleFactor).clamp(4.0, 12.0);
  static double get widthSm => (8.0.w * _webScaleFactor).clamp(8.0, 16.0);
  static double get widthMd => (16.0.w * _webScaleFactor).clamp(16.0, 32.0);
  static double get widthLg => (24.0.w * _webScaleFactor).clamp(24.0, 48.0);
  static double get widthXl => (32.0.w * _webScaleFactor).clamp(32.0, 64.0);

  // Border Radius
  static double get radiusXs => (4.0.r * _webScaleFactor).clamp(4.0, 12.0);
  static double get radiusSm => (8.0.r * _webScaleFactor).clamp(8.0, 16.0);
  static double get radiusMd => (12.0.r * _webScaleFactor).clamp(12.0, 24.0);
  static double get radiusLg => (16.0.r * _webScaleFactor).clamp(16.0, 32.0);
  static double get radiusXl => (24.0.r * _webScaleFactor).clamp(24.0, 48.0);

  // Icon Sizes
  static double get iconXs => (16.0.w * _webScaleFactor).clamp(16.0, 32.0);
  static double get iconSm => (20.0.w * _webScaleFactor).clamp(20.0, 40.0);
  static double get iconMd => (24.0.w * _webScaleFactor).clamp(24.0, 48.0);
  static double get iconLg => (32.0.w * _webScaleFactor).clamp(32.0, 64.0);
  static double get iconXl => (48.0.w * _webScaleFactor).clamp(48.0, 96.0);

  // Button Heights
  static double get buttonHeightSm =>
      (32.0.h * _webScaleFactor).clamp(32.0, 64.0);
  static double get buttonHeightMd =>
      (40.0.h * _webScaleFactor).clamp(40.0, 80.0);
  static double get buttonHeightLg =>
      (48.0.h * _webScaleFactor).clamp(48.0, 96.0);
  static double get buttonHeightXl =>
      (56.0.h * _webScaleFactor).clamp(56.0, 112.0);

  // Input Field Heights
  static double get inputHeightSm =>
      (40.0.h * _webScaleFactor).clamp(40.0, 80.0);
  static double get inputHeightMd =>
      (48.0.h * _webScaleFactor).clamp(48.0, 96.0);
  static double get inputHeightLg =>
      (56.0.h * _webScaleFactor).clamp(56.0, 112.0);

  // Card Dimensions
  static double get cardPadding => (16.0.w * _webScaleFactor).clamp(16.0, 32.0);
  static double get cardMargin => (8.0.w * _webScaleFactor).clamp(8.0, 16.0);
  static double get cardRadius => (12.0.r * _webScaleFactor).clamp(12.0, 24.0);

  // App Bar
  static double get appBarHeight =>
      (56.0.h * _webScaleFactor).clamp(56.0, 112.0);
  static double get appBarPadding =>
      (16.0.w * _webScaleFactor).clamp(16.0, 32.0);

  // Bottom Navigation
  static double get bottomNavHeight =>
      (60.0.h * _webScaleFactor).clamp(60.0, 120.0);
  static double get bottomNavPadding =>
      (8.0.w * _webScaleFactor).clamp(8.0, 16.0);

  // Dialog
  static double get dialogPadding =>
      (24.0.w * _webScaleFactor).clamp(24.0, 48.0);
  static double get dialogRadius =>
      (16.0.r * _webScaleFactor).clamp(16.0, 32.0);
  static double get dialogMaxWidth =>
      (400.0.w * _webScaleFactor).clamp(400.0, 800.0);

  // List Item
  static double get listItemPadding =>
      (16.0.w * _webScaleFactor).clamp(16.0, 32.0);
  static double get listItemHeight =>
      (56.0.h * _webScaleFactor).clamp(56.0, 112.0);

  // Divider
  static double get dividerHeight => (1.0.h * _webScaleFactor).clamp(1.0, 2.0);
  static double get dividerPadding =>
      (16.0.w * _webScaleFactor).clamp(16.0, 32.0);

  // Handle Bar
  static double get handleBarWidth =>
      (40.0.w * _webScaleFactor).clamp(40.0, 80.0);
  static double get handleBarHeight =>
      (4.0.h * _webScaleFactor).clamp(4.0, 8.0);
  static double get handleBarRadius =>
      (2.0.r * _webScaleFactor).clamp(2.0, 4.0);

  // Todo Bullet
  static double get todoBulletSize => (4.0.w * _webScaleFactor).clamp(4.0, 8.0);

  // Icon Button
  static double get iconButtonSize =>
      (12.0.w * _webScaleFactor).clamp(12.0, 24.0);

  // Content Preview
  static int get contentPreviewThreshold => 100;
  static int get maxPreviewLines => 3;
  static int get maxPreviewSentences => 2;
  static int get maxPreviewTodos => 3;

  // Expand/Collapse Icons
  static double get expandIconSize =>
      (20.0.w * _webScaleFactor).clamp(20.0, 40.0);
  static double get todoExpandIconSize =>
      (16.0.w * _webScaleFactor).clamp(16.0, 32.0);

  // Font Sizes
  static double get todoTextSize =>
      (12.0.sp * _webScaleFactor).clamp(12.0, 24.0);
  static double get todoExpandTextSize =>
      (11.0.sp * _webScaleFactor).clamp(11.0, 22.0);

  // Shadow
  static double get shadowBlurRadius =>
      (20.0.w * _webScaleFactor).clamp(20.0, 40.0);

  // Title
  static int get maxTitleLines => 2;

  // Loading Indicator
  static double get loadingIndicatorSize =>
      (60.0.w * _webScaleFactor).clamp(60.0, 120.0);
  static double get loadingIndicatorRadius =>
      (30.0.r * _webScaleFactor).clamp(30.0, 60.0);

  // Animation
  static int get animationDuration => 200;
}
