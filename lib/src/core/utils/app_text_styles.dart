import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

/// Application text style constants
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Headline Styles
  static TextStyle get headlineLarge => TextStyle(
    fontSize: 32.0.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: 28.0.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Title Styles
  static TextStyle get titleLarge => TextStyle(
    fontSize: 22.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get titleMedium => TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get titleSmall => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body Styles
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Label Styles
  static TextStyle get labelLarge => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 10.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Button Styles
  static TextStyle get buttonLarge => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static TextStyle get buttonMedium => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static TextStyle get buttonSmall => TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  // Special Styles
  static TextStyle get caption => TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get overline => TextStyle(
    fontSize: 10.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 1.5,
  );

  // Custom Styles
  static TextStyle get appBarTitle => TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static TextStyle get cardTitle => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get cardSubtitle => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get errorText => TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    height: 1.4,
  );

  static TextStyle get successText => TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.success,
    height: 1.4,
  );

  static TextStyle get linkText => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.4,
    decoration: TextDecoration.underline,
  );
}
