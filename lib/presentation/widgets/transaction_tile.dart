import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../core/constants/app_constants.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/format_utils.dart';
import '../../data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onDelete;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onDelete,
  });

  CategoryModel get _category {
    final list = transaction.type == TransactionType.income
        ? AppConstants.incomeCategories
        : AppConstants.expenseCategories;
    return list.firstWhere(
      (c) => c.id == transaction.categoryId,
      orElse: () => list.last,
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final lang = LocaleController.languageCode;
    final isIncome = transaction.type == TransactionType.income;
    final cat = _category;

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.expense.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.expense),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.border, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Color(cat.colorHex).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(cat.emoji, style: const TextStyle(fontSize: 20)),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                      letterSpacing: -0.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(2),
                  Text(
                    '${cat.localizedName(lang)} • ${FormatUtils.formatDate(transaction.date)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: c.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isIncome ? '+' : '-'} ${FormatUtils.formatCurrencyCompact(transaction.amount)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isIncome ? AppColors.income : AppColors.expense,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
