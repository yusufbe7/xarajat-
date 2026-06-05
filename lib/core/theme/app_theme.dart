import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary - O'zbek ko'ki (ultramarine)
  static const primary = Color(0xFF1B4FD8);
  static const primaryLight = Color(0xFF3D6EF5);
  static const primaryDark = Color(0xFF0D3399);

  // Accent - Oltin sariq (O'zbek milliy rangi)
  static const accent = Color(0xFFF5A623);
  static const accentLight = Color(0xFFFFBD4F);

  // Semantik ranglar
  static const income = Color(0xFF27AE60);
  static const expense = Color(0xFFE74C3C);
  static const saving = Color(0xFF8E44AD);

  // Neytral
  static const background = Color(0xFFF8F9FF);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF0F3FF);
  static const border = Color(0xFFE8ECF8);

  // Matn
  static const textPrimary = Color(0xFF1A1F36);
  static const textSecondary = Color(0xFF6B7494);
  static const textHint = Color(0xFFB0B8D4);

  // Dark mode
  static const darkBackground = Color(0xFF0F1225);
  static const darkSurface = Color(0xFF1A1F36);
  static const darkSurfaceVariant = Color(0xFF242942);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          background: AppColors.background,
          surface: AppColors.surface,
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: GoogleFonts.nunito().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
        cardTheme: CardTheme(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          hintStyle: const TextStyle(color: AppColors.textHint),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textHint,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          background: AppColors.darkBackground,
          surface: AppColors.darkSurface,
          primary: AppColors.primaryLight,
          secondary: AppColors.accent,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
        fontFamily: GoogleFonts.nunito().fontFamily,
      );
}
