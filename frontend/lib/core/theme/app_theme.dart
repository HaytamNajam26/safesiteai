import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design system colors extracted from HTML/Tailwind mockups
class AppColors {
  // Login Screen (Dark Theme)
  static const Color loginPrimary = Color(0xFFCC0000);
  static const Color loginBackground = Color(0xFF121212);
  static const Color loginSurface = Color(0xFF2A2A2A);
  static const Color loginTextPrimary = Color(0xFFEAEAEA);
  static const Color loginTextSecondary = Color(0xFFB0B0B0);

  // Dashboard/Sites (Light Theme)
  static const Color primaryBlue = Color(0xFF1489F0);
  static const Color primaryDeepBlue = Color(0xFF003366);
  static const Color backgroundLight = Color(0xFFF5F5F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textLightPrimary = Color(0xFF1C1C1E);
  static const Color textLightSecondary = Color(0xFF6E6E73);
  static const Color borderLight = Color(0xFFE5E5E7);

  // Risk Colors (Shared)
  static const Color riskHigh = Color(0xFFD32F2F);
  static const Color riskMedium = Color(0xFFFFA000);
  static const Color riskLow = Color(0xFF388E3C);

  // AI Result Screen
  static const Color aiPrimary = Color(0xFF007BFF);
  static const Color aiBackground = Color(0xFFF8F9FA);
  static const Color aiTextPrimary = Color(0xFF212529);
  static const Color aiTextSecondary = Color(0xFF6C757D);

  // Warning/Danger for form
  static const Color warning = Color(0xFFFFC107);
  static const Color danger = Color(0xFFDC3545);
}

/// Border radius values from Tailwind config
class AppRadius {
  static const double sm = 8.0;       // rounded-DEFAULT (0.5rem)
  static const double md = 12.0;      // custom
  static const double lg = 16.0;      // rounded-lg (1rem)
  static const double xl = 24.0;      // rounded-xl (1.5rem)
  static const double full = 9999.0;  // rounded-full
}

/// App theme configuration
class AppTheme {
  /// Light theme for Dashboard, Sites, Forms, AI Result screens
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryDeepBlue,
        surface: AppColors.surfaceLight,
        error: AppColors.riskHigh,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).apply(
        bodyColor: AppColors.textLightPrimary,
        displayColor: AppColors.textLightPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight.withValues(alpha: 0.8),
        foregroundColor: AppColors.textLightPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textLightPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: BorderSide(color: AppColors.borderLight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
      ),
    );
  }

  /// Dark theme for Login screen
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.loginBackground,
      colorScheme: ColorScheme.dark(
        primary: AppColors.loginPrimary,
        surface: AppColors.loginSurface,
        error: AppColors.riskHigh,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.loginTextPrimary,
        displayColor: AppColors.loginTextPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.loginSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(
            color: AppColors.loginPrimary.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: TextStyle(color: AppColors.loginTextSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.loginPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
