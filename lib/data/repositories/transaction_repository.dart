import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  static const _boxName = 'transactions';

  Box<TransactionModel> get _box => Hive.box<TransactionModel>(_boxName);

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    await Hive.openBox<TransactionModel>(_boxName);
  }

  List<TransactionModel> getAll() {
    return _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<TransactionModel> getByMonth(int year, int month) {
    return _box.values
        .where((t) => t.date.year == year && t.date.month == month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> add(TransactionModel transaction) async {
    await _box.put(transaction.id, transaction);
  }

  Future<void> update(TransactionModel transaction) async {
    await _box.put(transaction.id, transaction);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  double getTotalIncome({int? year, int? month}) {
    var list = (year != null && month != null)
        ? getByMonth(year, month)
        : getAll();
    return list
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double getTotalExpense({int? year, int? month}) {
    var list = (year != null && month != null)
        ? getByMonth(year, month)
        : getAll();
    return list
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  Map<String, double> getExpenseByCategory({int? year, int? month}) {
    var list = (year != null && month != null)
        ? getByMonth(year, month)
        : getAll();
    final expenses = list.where((t) => t.type == TransactionType.expense);
    final Map<String, double> result = {};
    for (final t in expenses) {
      result[t.categoryId] = (result[t.categoryId] ?? 0) + t.amount;
    }
    return result;
  }
}
