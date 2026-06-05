import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/format_utils.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/transaction_repository.dart';

class AnalyticsScreen extends StatelessWidget {
  final TransactionRepository repo;
  const AnalyticsScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final byCategory = repo.getExpenseByCategory(year: now.year, month: now.month);
    final totalExpense = repo.getTotalExpense(year: now.year, month: now.month);
    final totalIncome = repo.getTotalIncome(year: now.year, month: now.month);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Tahlil',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(20),

          // Monthly summary
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  label: 'Kirim',
                  amount: totalIncome,
                  color: AppColors.income,
                  icon: '📈',
                ),
              ),
              const Gap(12),
              Expanded(
                child: _SummaryCard(
                  label: 'Chiqim',
                  amount: totalExpense,
                  color: AppColors.expense,
                  icon: '📉',
                ),
              ),
            ],
          ),

          const Gap(24),

          if (byCategory.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  'Bu oyda xarajat yo\'q',
                  style: TextStyle(color: AppColors.textHint, fontSize: 15),
                ),
              ),
            )
          else ...[
            const Text(
              'Kategoriyalar bo\'yicha',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(16),

            // Pie chart
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _buildSections(byCategory, totalExpense),
                  centerSpaceRadius: 60,
                  sectionsSpace: 3,
                ),
              ),
            ),

            const Gap(20),

            // Category breakdown
            ...byCategory.entries.map((entry) {
              final cat = AppConstants.expenseCategories.firstWhere(
                (c) => c.id == entry.key,
                orElse: () => AppConstants.expenseCategories.last,
              );
              final pct = totalExpense > 0
                  ? (entry.value / totalExpense * 100).toStringAsFixed(1)
                  : '0';
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(cat.colorHex).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(cat.emoji,
                            style: const TextStyle(fontSize: 18)),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cat.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary)),
                              Text(
                                  FormatUtils.formatCurrencyCompact(
                                      entry.value),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.expense)),
                            ],
                          ),
                          const Gap(4),
                          LinearProgressIndicator(
                            value: totalExpense > 0
                                ? entry.value / totalExpense
                                : 0,
                            backgroundColor: AppColors.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation(
                                Color(cat.colorHex)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const Gap(2),
                          Text('$pct%',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections(
      Map<String, double> data, double total) {
    return data.entries.map((e) {
      final cat = AppConstants.expenseCategories.firstWhere(
        (c) => c.id == e.key,
        orElse: () => AppConstants.expenseCategories.last,
      );
      return PieChartSectionData(
        value: e.value,
        color: Color(cat.colorHex),
        title: cat.emoji,
        radius: 50,
        titleStyle: const TextStyle(fontSize: 16),
      );
    }).toList();
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final String icon;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const Gap(8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(2),
          Text(
            FormatUtils.formatCurrencyCompact(amount),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
