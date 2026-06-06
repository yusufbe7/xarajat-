import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/format_utils.dart';
import '../../../data/repositories/transaction_repository.dart';

enum AnalyticsPeriod { thisMonth, lastMonth, allTime }

class AnalyticsScreen extends StatefulWidget {
  final TransactionRepository repo;
  const AnalyticsScreen({super.key, required this.repo});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AnalyticsPeriod _period = AnalyticsPeriod.thisMonth;

  TransactionRepository get repo => widget.repo;

  ({int? year, int? month}) get _periodArgs {
    final now = DateTime.now();
    switch (_period) {
      case AnalyticsPeriod.thisMonth:
        return (year: now.year, month: now.month);
      case AnalyticsPeriod.lastMonth:
        final lm = DateTime(now.year, now.month - 1);
        return (year: lm.year, month: lm.month);
      case AnalyticsPeriod.allTime:
        return (year: null, month: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    final args = _periodArgs;

    final byCategory =
        repo.getExpenseByCategory(year: args.year, month: args.month);
    final totalExpense =
        repo.getTotalExpense(year: args.year, month: args.month);
    final totalIncome =
        repo.getTotalIncome(year: args.year, month: args.month);
    final balance = totalIncome - totalExpense;
    final savingsRate =
        totalIncome > 0 ? (balance / totalIncome * 100) : 0.0;

    // Top kategoriyalarni saralash
    final sortedCategories = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.analytics,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: c.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(16),

          // Period selector
          _PeriodSelector(
            period: _period,
            onChanged: (p) => setState(() => _period = p),
          ),

          const Gap(20),

          // Summary cards
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  label: l10n.income,
                  amount: totalIncome,
                  color: AppColors.income,
                  icon: Iconsax.arrow_down,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _SummaryCard(
                  label: l10n.expense,
                  amount: totalExpense,
                  color: AppColors.expense,
                  icon: Iconsax.arrow_up,
                ),
              ),
            ],
          ),

          const Gap(12),

          // Balance / savings card
          _BalanceMiniCard(
            balance: balance,
            savingsRate: savingsRate,
          ),

          const Gap(24),

          // 6-oylik trend
          Text(
            l10n.incomeVsExpense,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          const Gap(4),
          Text(
            l10n.last6Months,
            style: TextStyle(fontSize: 13, color: c.textSecondary),
          ),
          const Gap(16),
          _MonthlyTrendChart(repo: repo),

          const Gap(28),

          // Kategoriyalar
          if (byCategory.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Column(
                  children: [
                    Icon(Iconsax.chart, size: 40, color: c.textHint),
                    const Gap(12),
                    Text(
                      l10n.noExpenseThisMonth,
                      style: TextStyle(color: c.textHint, fontSize: 15),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            Text(
              l10n.byCategory,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
            const Gap(16),

            // Pie chart
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _buildSections(byCategory, totalExpense),
                  centerSpaceRadius: 56,
                  sectionsSpace: 3,
                ),
              ),
            ),

            const Gap(20),

            Text(
              l10n.topCategories,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
            const Gap(12),

            ...sortedCategories.map((entry) {
              final cat = AppConstants.expenseCategories.firstWhere(
                (c) => c.id == entry.key,
                orElse: () => AppConstants.expenseCategories.last,
              );
              final pct = totalExpense > 0
                  ? (entry.value / totalExpense * 100)
                  : 0.0;
              return _CategoryRow(
                category: cat,
                amount: entry.value,
                percent: pct,
              );
            }),
          ],

          const Gap(40),
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
        radius: 48,
        titleStyle: const TextStyle(fontSize: 16),
      );
    }).toList();
  }
}

class _PeriodSelector extends StatelessWidget {
  final AnalyticsPeriod period;
  final ValueChanged<AnalyticsPeriod> onChanged;

  const _PeriodSelector({required this.period, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    final items = {
      AnalyticsPeriod.thisMonth: l10n.thisMonth,
      AnalyticsPeriod.lastMonth: l10n.lastMonth,
      AnalyticsPeriod.allTime: l10n.allTime,
    };

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: items.entries.map((e) {
          final selected = e.key == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  e.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : c.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final IconData icon;

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
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const Gap(10),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              FormatUtils.formatCurrencyCompact(amount),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceMiniCard extends StatelessWidget {
  final double balance;
  final double savingsRate;

  const _BalanceMiniCard({required this.balance, required this.savingsRate});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    final positive = balance >= 0;
    final accent = positive ? AppColors.saving : AppColors.expense;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Iconsax.money, color: accent, size: 20),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.balance,
                  style: TextStyle(fontSize: 13, color: c.textSecondary),
                ),
                const Gap(2),
                Text(
                  FormatUtils.formatCurrencyCompact(balance),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: accent,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${l10n.savingsRate}: ${savingsRate.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final CategoryModel category;
  final double amount;
  final double percent;

  const _CategoryRow({
    required this.category,
    required this.amount,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final lang = LocaleController.languageCode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(category.colorHex).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(category.emoji, style: const TextStyle(fontSize: 18)),
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
                    Text(
                      category.localizedName(lang),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    Text(
                      FormatUtils.formatCurrencyCompact(amount),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.expense,
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (percent / 100).clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: c.surfaceVariant,
                    valueColor:
                        AlwaysStoppedAnimation(Color(category.colorHex)),
                  ),
                ),
                const Gap(2),
                Text(
                  '${percent.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 11, color: c.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyTrendChart extends StatelessWidget {
  final TransactionRepository repo;
  const _MonthlyTrendChart({required this.repo});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    final lang = LocaleController.languageCode;
    final now = DateTime.now();

    // Oxirgi 6 oy (eskidan yangiga)
    final months = List.generate(6, (i) {
      return DateTime(now.year, now.month - (5 - i));
    });

    final incomes = months
        .map((m) => repo.getTotalIncome(year: m.year, month: m.month))
        .toList();
    final expenses = months
        .map((m) => repo.getTotalExpense(year: m.year, month: m.month))
        .toList();

    final maxVal = [
      ...incomes,
      ...expenses,
      1.0,
    ].reduce((a, b) => a > b ? a : b);

    final hasData =
        incomes.any((e) => e > 0) || expenses.any((e) => e > 0);

    if (!hasData) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.border),
        ),
        child: Center(
          child: Text(l10n.noData,
              style: TextStyle(color: c.textHint, fontSize: 14)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.border),
      ),
      child: Column(
        children: [
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color: AppColors.income, label: l10n.income),
              const Gap(16),
              _LegendDot(color: AppColors.expense, label: l10n.expense),
            ],
          ),
          const Gap(16),
          SizedBox(
            height: 160,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxVal * 1.2,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        FormatUtils.formatCurrencyCompact(rod.toY),
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= months.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            AppConstants.monthShort(months[i].month, lang),
                            style: TextStyle(
                              fontSize: 11,
                              color: c.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(months.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: incomes[i],
                        color: AppColors.income,
                        width: 7,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(3),
                        ),
                      ),
                      BarChartRodData(
                        toY: expenses[i],
                        color: AppColors.expense,
                        width: 7,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(3),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const Gap(6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: c.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
