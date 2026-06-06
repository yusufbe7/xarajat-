import 'package:intl/intl.dart';
import '../constants/app_constants.dart';
import '../localization/locale_controller.dart';

class FormatUtils {
  // Probel bilan guruhlash (1 000 000) — uz va ru uchun ham mos.
  static final _grouped = NumberFormat('#,###', 'en_US');

  static String _group(int value) =>
      _grouped.format(value).replaceAll(',', ' ');

  static String _unit() => LocaleController.languageCode == 'ru' ? 'сум' : "so'm";
  static String _thousand() =>
      LocaleController.languageCode == 'ru' ? 'тыс. сум' : "ming so'm";
  static String _million() =>
      LocaleController.languageCode == 'ru' ? 'млн сум' : "mln so'm";
  static String _billion() =>
      LocaleController.languageCode == 'ru' ? 'млрд сум' : "mlrd so'm";

  static String formatCurrency(double amount) {
    return '${_group(amount.toInt())} ${_unit()}';
  }

  static String formatCurrencyCompact(double amount) {
    final abs = amount.abs();
    final sign = amount < 0 ? '-' : '';
    if (abs >= 1000000000) {
      return '$sign${(abs / 1000000000).toStringAsFixed(1)} ${_billion()}';
    } else if (abs >= 1000000) {
      return '$sign${(abs / 1000000).toStringAsFixed(1)} ${_million()}';
    } else if (abs >= 1000) {
      return '$sign${(abs / 1000).toStringAsFixed(0)} ${_thousand()}';
    }
    return '$sign${abs.toInt()} ${_unit()}';
  }

  static String formatDate(DateTime date) {
    final lang = LocaleController.languageCode;
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return lang == 'ru' ? 'Сегодня' : 'Bugun';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year) {
      return lang == 'ru' ? 'Вчера' : 'Kecha';
    }
    return '${date.day} ${AppConstants.monthShort(date.month, lang)}';
  }
}
