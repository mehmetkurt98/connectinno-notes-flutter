import 'package:flutter/material.dart';

/// Application color constants
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFFF6B35); // Vibrant Orange
  static const Color primaryLight = Color(0xFFFF8A65); // Light Orange
  static const Color primaryDark = Color(0xFFE64A19); // Dark Orange

  // Secondary Colors
  static const Color secondary = Color(0xFFFFB74D); // Warm Orange
  static const Color secondaryLight = Color(0xFFFFCC80); // Light Warm Orange
  static const Color secondaryDark = Color(0xFFFF8A00); // Dark Warm Orange

  // Background Colors
  static const Color background = Color(0xFFFAFAFA); // Light Gray
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Light Gray

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Dark Gray
  static const Color textSecondary = Color(0xFF757575); // Medium Gray
  static const Color textHint = Color(0xFFBDBDBD); // Light Gray
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFF44336); // Red
  static const Color info = Color(0xFF2196F3); // Blue

  // Border Colors
  static const Color border = Color(0xFFE0E0E0); // Light Gray
  static const Color borderFocus = Color(0xFFFF6B35); // Primary Orange
  static const Color borderError = Color(0xFFF44336); // Error

  // Icon Colors
  static const Color iconPrimary = Color(0xFF757575); // Medium Gray
  static const Color iconSecondary = Color(0xFFBDBDBD); // Light Gray
  static const Color iconOnPrimary = Color(0xFFFFFFFF); // White

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF); // White
  static const Color cardShadow = Color(0x1A000000); // Black with opacity

  // Button Colors
  static const Color buttonPrimary = Color(0xFFFF6B35); // Primary Orange
  static const Color buttonSecondary = Color(0xFF757575); // Medium Gray
  static const Color buttonDisabled = Color(0xFFBDBDBD); // Light Gray

  // Divider Colors
  static const Color divider = Color(0xFFE0E0E0); // Light Gray
  static const Color dividerLight = Color(0xFFF5F5F5); // Very Light Gray

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // Black with opacity
  static const Color overlayLight = Color(
    0x40000000,
  ); // Black with less opacity

  // Todo Colors
  static const Color todoBackground = Color(0xFFFFF3E0); // Light Orange
  static const Color todoBorder = Color(0xFFFFCC80); // Medium Orange
  static const Color todoIcon = Color(0xFFFF9800); // Orange
  static const Color todoText = Color(0xFFE65100); // Dark Orange
  static const Color todoBullet = Color(0xFFFFB74D); // Light Orange

  // Handle Bar Colors
  static const Color handleBar = Color(0xFFBDBDBD); // Light Gray

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // Black with 10% opacity
  static const Color shadowMedium = Color(0x33000000); // Black with 20% opacity

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B35), Color(0xFFFF8A65)],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB74D), Color(0xFFFF8A00)],
  );

  // Card Gradient
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xE6FFFFFF), Color(0xCCF5F5F5)], // White with opacity
  );
}
