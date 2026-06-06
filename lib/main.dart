import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/transaction_repository.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TransactionRepository.init();
  await LocaleController.load();
  runApp(const XarajatApp());
}

class XarajatApp extends StatelessWidget {
  const XarajatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleController.locale,
      builder: (context, locale, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: LocaleController.themeMode,
          builder: (context, themeMode, __) {
            return MaterialApp(
              title: 'Xarajat',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: LocaleController.supportedLocales,
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
