import 'package:flutter/material.dart';

/// Ilova lokalizatsiyasi. O'zbek (uz) va rus (ru) tillarini qo'llab-quvvatlaydi.
///
/// Foydalanish: `AppLocalizations.of(context).save` yoki qisqacha
/// `context.l10n.save`.
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLanguageCodes = ['uz', 'ru'];

  String _t(String key) {
    final lang = _values.containsKey(locale.languageCode)
        ? locale.languageCode
        : 'uz';
    return _values[lang]![key] ?? _values['uz']![key] ?? key;
  }

  // Umumiy
  String get appName => _t('appName');
  String get greeting => _t('greeting');
  String get yourAccount => _t('yourAccount');
  String get income => _t('income');
  String get expense => _t('expense');
  String get totalBalance => _t('totalBalance');
  String get save => _t('save');
  String get today => _t('today');
  String get yesterday => _t('yesterday');

  // Pastki navigatsiya
  String get navHome => _t('navHome');
  String get navAnalytics => _t('navAnalytics');
  String get navSettings => _t('navSettings');

  // Home
  String get recentTransactions => _t('recentTransactions');
  String get noTransactionsThisMonth => _t('noTransactionsThisMonth');
  String get noTransactionsHint => _t('noTransactionsHint');
  String countItems(int n) => '$n ${_t('itemsSuffix')}';

  // Add transaction
  String get newTransaction => _t('newTransaction');
  String get selectCategory => _t('selectCategory');
  String get tabIncome => _t('tabIncome');
  String get tabExpense => _t('tabExpense');
  String get amountLabel => _t('amountLabel');
  String get enterAmount => _t('enterAmount');
  String get enterValidAmount => _t('enterValidAmount');
  String get titleLabel => _t('titleLabel');
  String get titleHint => _t('titleHint');
  String get enterTitle => _t('enterTitle');
  String get category => _t('category');
  String get noteLabel => _t('noteLabel');
  String get noteHint => _t('noteHint');
  String get transactionAdded => _t('transactionAdded');
  String get transactionDeleted => _t('transactionDeleted');
  String get undo => _t('undo');

  // Analytics
  String get analytics => _t('analytics');
  String get noExpenseThisMonth => _t('noExpenseThisMonth');
  String get byCategory => _t('byCategory');
  String get thisMonth => _t('thisMonth');
  String get lastMonth => _t('lastMonth');
  String get allTime => _t('allTime');
  String get incomeVsExpense => _t('incomeVsExpense');
  String get balance => _t('balance');
  String get last6Months => _t('last6Months');
  String get topCategories => _t('topCategories');
  String get noData => _t('noData');
  String get savingsRate => _t('savingsRate');

  // Settings
  String get settings => _t('settings');
  String get aboutApp => _t('aboutApp');
  String get version => _t('version');
  String get language => _t('language');
  String get currency => _t('currency');
  String get appearance => _t('appearance');
  String get themeMode => _t('themeMode');
  String get themeSystem => _t('themeSystem');
  String get themeLight => _t('themeLight');
  String get themeDark => _t('themeDark');
  String get information => _t('information');
  String get privacyPolicy => _t('privacyPolicy');
  String get termsOfUse => _t('termsOfUse');
  String get footer => _t('footer');
  String get selectLanguage => _t('selectLanguage');
  String get uzbek => _t('uzbek');
  String get russian => _t('russian');

  // Valyuta birliklari
  String get currencyUnit => _t('currencyUnit');
  String get thousand => _t('thousand');
  String get million => _t('million');
  String get billion => _t('billion');
  String get currencyName => _t('currencyName');

  static const Map<String, Map<String, String>> _values = {
    'uz': {
      'appName': 'Xarajat',
      'greeting': 'Salom! 👋',
      'yourAccount': 'Hisobingiz',
      'income': 'Kirim',
      'expense': 'Chiqim',
      'totalBalance': 'Umumiy balans',
      'save': 'Saqlash',
      'today': 'Bugun',
      'yesterday': 'Kecha',
      'navHome': 'Asosiy',
      'navAnalytics': 'Tahlil',
      'navSettings': 'Sozlamalar',
      'recentTransactions': "So'nggi operatsiyalar",
      'noTransactionsThisMonth': "Bu oyda operatsiya yo'q",
      'noTransactionsHint':
          "+ tugmani bosib birinchi\nxarajatingizni kiriting",
      'itemsSuffix': 'ta',
      'newTransaction': 'Yangi operatsiya',
      'selectCategory': 'Kategoriya tanlang',
      'tabIncome': '💰 Kirim',
      'tabExpense': '💸 Chiqim',
      'amountLabel': "Summa (so'mda)",
      'enterAmount': 'Summani kiriting',
      'enterValidAmount': "To'g'ri summa kiriting",
      'titleLabel': 'Sarlavha',
      'titleHint': 'Masalan: Korzinkaga borish',
      'enterTitle': 'Sarlavha kiriting',
      'category': 'Kategoriya',
      'noteLabel': 'Izoh (ixtiyoriy)',
      'noteHint': "Qo'shimcha ma'lumot...",
      'transactionAdded': "Operatsiya qo'shildi",
      'transactionDeleted': "Operatsiya o'chirildi",
      'undo': 'Qaytarish',
      'analytics': 'Tahlil',
      'noExpenseThisMonth': "Bu davrda xarajat yo'q",
      'byCategory': "Kategoriyalar bo'yicha",
      'thisMonth': 'Shu oy',
      'lastMonth': "O'tgan oy",
      'allTime': 'Hammasi',
      'incomeVsExpense': 'Kirim va chiqim',
      'balance': 'Balans',
      'last6Months': "So'nggi 6 oy",
      'topCategories': 'Eng ko\'p xarajatlar',
      'noData': "Ma'lumot yo'q",
      'savingsRate': 'Jamg\'arma',
      'settings': 'Sozlamalar',
      'aboutApp': 'Ilova haqida',
      'version': 'Versiya',
      'language': 'Til',
      'currency': 'Valyuta',
      'appearance': "Ko'rinish",
      'themeMode': 'Mavzu',
      'themeSystem': 'Tizim bo\'yicha',
      'themeLight': 'Yorug\'',
      'themeDark': 'Qorong\'i',
      'information': "Ma'lumot",
      'privacyPolicy': 'Maxfiylik siyosati',
      'termsOfUse': 'Foydalanish shartlari',
      'footer': "Xarajat — O'zbek moliya yordamchisi 🇺🇿",
      'selectLanguage': 'Tilni tanlang',
      'uzbek': "O'zbekcha",
      'russian': 'Ruscha',
      'currencyUnit': "so'm",
      'thousand': "ming so'm",
      'million': "mln so'm",
      'billion': "mlrd so'm",
      'currencyName': "So'm (UZS)",
    },
    'ru': {
      'appName': 'Xarajat',
      'greeting': 'Привет! 👋',
      'yourAccount': 'Ваш счёт',
      'income': 'Доход',
      'expense': 'Расход',
      'totalBalance': 'Общий баланс',
      'save': 'Сохранить',
      'today': 'Сегодня',
      'yesterday': 'Вчера',
      'navHome': 'Главная',
      'navAnalytics': 'Анализ',
      'navSettings': 'Настройки',
      'recentTransactions': 'Последние операции',
      'noTransactionsThisMonth': 'В этом месяце нет операций',
      'noTransactionsHint':
          'Нажмите +, чтобы добавить\nпервую операцию',
      'itemsSuffix': 'шт.',
      'newTransaction': 'Новая операция',
      'selectCategory': 'Выберите категорию',
      'tabIncome': '💰 Доход',
      'tabExpense': '💸 Расход',
      'amountLabel': 'Сумма (в сумах)',
      'enterAmount': 'Введите сумму',
      'enterValidAmount': 'Введите корректную сумму',
      'titleLabel': 'Название',
      'titleHint': 'Например: Поход в магазин',
      'enterTitle': 'Введите название',
      'category': 'Категория',
      'noteLabel': 'Примечание (необязательно)',
      'noteHint': 'Дополнительная информация...',
      'transactionAdded': 'Операция добавлена',
      'transactionDeleted': 'Операция удалена',
      'undo': 'Отменить',
      'analytics': 'Анализ',
      'noExpenseThisMonth': 'Нет расходов за этот период',
      'byCategory': 'По категориям',
      'thisMonth': 'Этот месяц',
      'lastMonth': 'Прошлый месяц',
      'allTime': 'Всё время',
      'incomeVsExpense': 'Доходы и расходы',
      'balance': 'Баланс',
      'last6Months': 'Последние 6 месяцев',
      'topCategories': 'Крупнейшие расходы',
      'noData': 'Нет данных',
      'savingsRate': 'Накопления',
      'settings': 'Настройки',
      'aboutApp': 'О приложении',
      'version': 'Версия',
      'language': 'Язык',
      'currency': 'Валюта',
      'appearance': 'Оформление',
      'themeMode': 'Тема',
      'themeSystem': 'Как в системе',
      'themeLight': 'Светлая',
      'themeDark': 'Тёмная',
      'information': 'Информация',
      'privacyPolicy': 'Политика конфиденциальности',
      'termsOfUse': 'Условия использования',
      'footer': 'Xarajat — финансовый помощник 🇺🇿',
      'selectLanguage': 'Выберите язык',
      'uzbek': 'Узбекский',
      'russian': 'Русский',
      'currencyUnit': 'сум',
      'thousand': 'тыс. сум',
      'million': 'млн сум',
      'billion': 'млрд сум',
      'currencyName': 'Сум (UZS)',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Qisqartma: `context.l10n.save`
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
