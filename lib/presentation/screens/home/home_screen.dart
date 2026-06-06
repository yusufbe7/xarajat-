import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/transaction_tile.dart';
import '../add_transaction/add_transaction_screen.dart';
import '../analytics/analytics_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _repo = TransactionRepository();
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now();
  }

  List<TransactionModel> get _transactions =>
      _repo.getByMonth(_selectedMonth.year, _selectedMonth.month);

  double get _income => _repo.getTotalIncome(
      year: _selectedMonth.year, month: _selectedMonth.month);

  double get _expense => _repo.getTotalExpense(
      year: _selectedMonth.year, month: _selectedMonth.month);

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _nextMonth() {
    final now = DateTime.now();
    if (_selectedMonth.year == now.year && _selectedMonth.month == now.month) {
      return;
    }
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    });
  }

  bool get _isCurrentMonth {
    final now = DateTime.now();
    return _selectedMonth.year == now.year && _selectedMonth.month == now.month;
  }

  String get _monthLabel {
    final lang = LocaleController.languageCode;
    return '${AppConstants.monthName(_selectedMonth.month, lang)} ${_selectedMonth.year}';
  }

  Future<void> _deleteTransaction(TransactionModel t) async {
    await _repo.delete(t.id);
    setState(() {});
    if (!mounted) return;
    final l10n = context.l10n;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.transactionDeleted),
          action: SnackBarAction(
            label: l10n.undo,
            onPressed: () async {
              await _repo.add(t);
              setState(() {});
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeTab(),
            AnalyticsScreen(repo: _repo),
            const SettingsScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(),
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: _openAddTransaction,
                backgroundColor: AppColors.primary,
                child: const Icon(Iconsax.add, color: Colors.white, size: 28),
              )
            : null,
      ),
    );
  }

  Widget _buildHomeTab() {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    final transactions = _transactions;
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.greeting,
                          style: TextStyle(
                            fontSize: 14,
                            color: c.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          l10n.yourAccount,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: c.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: c.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: _previousMonth,
                          icon: const Icon(Iconsax.arrow_left_2, size: 18),
                          color: c.textSecondary,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            _monthLabel,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: c.textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _isCurrentMonth ? null : _nextMonth,
                          icon: const Icon(Iconsax.arrow_right_3, size: 18),
                          color: _isCurrentMonth
                              ? c.textHint
                              : c.textSecondary,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Balance card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: BalanceCard(
                balance: _income - _expense,
                income: _income,
                expense: _expense,
              ),
            ),
          ),

          // Transactions header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.recentTransactions,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  if (transactions.isNotEmpty)
                    Text(
                      l10n.countItems(transactions.length),
                      style: TextStyle(
                        fontSize: 13,
                        color: c.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Transactions list
          transactions.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final t = transactions[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                        child: TransactionTile(
                          transaction: t,
                          onDelete: () => _deleteTransaction(t),
                        ),
                      );
                    },
                    childCount: transactions.length,
                  ),
                ),

          const SliverGap(100),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: c.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.receipt_item,
              size: 36,
              color: c.textHint,
            ),
          ),
          const Gap(16),
          Text(
            l10n.noTransactionsThisMonth,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: c.textSecondary,
            ),
          ),
          const Gap(8),
          Text(
            l10n.noTransactionsHint,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: c.textHint,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final c = AppColors.of(context);
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: c.border, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.home_2),
            activeIcon: const Icon(Iconsax.home_25),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.chart),
            activeIcon: const Icon(Iconsax.chart5),
            label: l10n.navAnalytics,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.setting_2),
            activeIcon: const Icon(Iconsax.setting_25),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }

  void _openAddTransaction() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
    );
    setState(() {});
  }
}
