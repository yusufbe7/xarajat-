import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Ilova tili va mavzu (theme) rejimini boshqaruvchi global kontroller.
/// SharedPreferences orqali tanlovni saqlaydi.
class LocaleController {
  LocaleController._();

  static const _localeKey = 'app_locale';
  static const _themeKey = 'app_theme_mode';

  static const supportedLocales = [
    Locale('uz'),
    Locale('ru'),
  ];

  /// Joriy til. MaterialApp shu notifierга obuna bo'ladi.
  static final ValueNotifier<Locale> locale = ValueNotifier(const Locale('uz'));

  /// Joriy mavzu rejimi.
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.system);

  /// Joriy til kodi (masalan, 'uz' yoki 'ru'). FormatUtils kabi
  /// kontekstsiz joylarda foydalanish uchun.
  static String get languageCode => locale.value.languageCode;

  /// Saqlangan sozlamalarni yuklash.
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final code = prefs.getString(_localeKey);
    if (code != null) {
      locale.value = Locale(code);
    }

    final theme = prefs.getString(_themeKey);
    switch (theme) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      case 'system':
        themeMode.value = ThemeMode.system;
        break;
    }
  }

  static Future<void> setLocale(Locale value) async {
    if (locale.value == value) return;
    locale.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, value.languageCode);
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    if (themeMode.value == mode) return;
    themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }
}
