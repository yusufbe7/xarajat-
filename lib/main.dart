import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/transaction_repository.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TransactionRepository.init();
  runApp(const XarajatApp());
}

class XarajatApp extends StatelessWidget {
  const XarajatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xarajat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('uz', 'UZ'),
        Locale('ru', 'RU'),
      ],
      home: const HomeScreen(),
    );
  }
}
