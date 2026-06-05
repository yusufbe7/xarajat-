import 'package:intl/intl.dart';

class FormatUtils {
  static final _sumFormatter = NumberFormat('#,###', 'uz_UZ');

  static String formatCurrency(double amount) {
    return '${_sumFormatter.format(amount.toInt())} so\'m';
  }

  static String formatCurrencyCompact(double amount) {
    if (amount >= 1000000000) {
      return '${(amount / 1000000000).toStringAsFixed(1)} mlrd so\'m';
    } else if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)} mln so\'m';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)} ming so\'m';
    }
    return '${amount.toInt()} so\'m';
  }

  static String formatDate(DateTime date) {
    final months = [
      'yan', 'fev', 'mar', 'apr', 'may', 'iyn',
      'iyl', 'avg', 'sen', 'okt', 'noy', 'dek'
    ];
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Bugun';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year) {
      return 'Kecha';
    }
    return '${date.day} ${months[date.month - 1]}';
  }
}
