import 'dart:convert';
import 'package:myexpenses/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/expense.dart';

class ExpenseService {
  final String _expensesKey = 'expenses';

  Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getString(_expensesKey);
    if (jsonList != null) {
      return Expense.fromJsonList(jsonDecode(jsonList));
    }
    return [];
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jsonList = expenses.map((item) => item.toJson()).toList();
      final data = jsonEncode(jsonList);
      await prefs.setString(_expensesKey, data);
    } catch (error) {
      logger.e('Failed to save expenses:', error);
    }
  }
}
