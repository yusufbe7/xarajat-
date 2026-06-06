import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brend va semantik ranglar (ikkala rejimda ham bir xil) hamda
/// yorug'/qorong'i rejimga moslashuvchi neytral palitra.
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

  // --- Light neytral (eski kod bilan moslik uchun static const) ---
  static const background = Color(0xFFF8F9FF);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF0F3FF);
  static const border = Color(0xFFE8ECF8);
  static const textPrimary = Color(0xFF1A1F36);
  static const textSecondary = Color(0xFF6B7494);
  static const textHint = Color(0xFFB0B8D4);

  // --- Dark neytral ---
  static const darkBackground = Color(0xFF0F1225);
  static const darkSurface = Color(0xFF1A1F36);
  static const darkSurfaceVariant = Color(0xFF242942);
  static const darkBorder = Color(0xFF2C3354);
  static const darkTextPrimary = Color(0xFFF1F3FB);
  static const darkTextSecondary = Color(0xFF9AA3C4);
  static const darkTextHint = Color(0xFF5A6488);

  static const _light = AppPalette(
    background: background,
    surface: surface,
    surfaceVariant: surfaceVariant,
    border: border,
    textPrimary: textPrimary,
    textSecondary: textSecondary,
    textHint: textHint,
  );

  static const _dark = AppPalette(
    background: darkBackground,
    surface: darkSurface,
    surfaceVariant: darkSurfaceVariant,
    border: darkBorder,
    textPrimary: darkTextPrimary,
    textSecondary: darkTextSecondary,
    textHint: darkTextHint,
  );

  /// Joriy mavzuга mos neytral palitrani qaytaradi.
  static AppPalette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;
}

/// Mavzuга bog'liq neytral ranglar to'plami.
class AppPalette {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;

  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
  });
}

class AppTheme {
  static ThemeData get light => _base(
        brightness: Brightness.light,
        palette: AppColors._light,
        primary: AppColors.primary,
      );

  static ThemeData get dark => _base(
        brightness: Brightness.dark,
        palette: AppColors._dark,
        primary: AppColors.primaryLight,
      );

  static ThemeData _base({
    required Brightness brightness,
    required AppPalette palette,
    required Color primary,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        background: palette.background,
        surface: palette.surface,
        primary: primary,
        secondary: AppColors.accent,
        error: AppColors.expense,
      ),
      scaffoldBackgroundColor: palette.background,
      fontFamily: GoogleFonts.nunito().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: palette.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: palette.textPrimary),
      ),
      cardTheme: CardTheme(
        color: palette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: palette.border, width: 1),
        ),
      ),
      dividerColor: palette.border,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surfaceVariant,
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
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        labelStyle: TextStyle(color: palette.textSecondary),
        hintStyle: TextStyle(color: palette.textHint),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: palette.surface,
        selectedItemColor: primary,
        unselectedItemColor: palette.textHint,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
