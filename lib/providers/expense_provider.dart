import 'package:flutter/material.dart';

import '../entities/expense.dart';
import '../entities/user.dart';
import '../services/expense_service.dart';
import '../services/user_service.dart';

class ExpenseProvider with ChangeNotifier {
  late User _user;
  final UserService _userService;

  List<Expense> _expenses = [];
  final _expenseService = ExpenseService();
  Expense? _selecionado;
  Expense? get selecionado => _selecionado;
  int? _idx;

  int? get idx => _idx;

  ExpenseProvider({
    required UserService userService,
    List<Expense>? expenses,
    Expense? selecionado,
    int? idx,
  })  : _expenses = expenses ?? [],
        _userService = userService,
        _idx = idx {
    _initializeUser();
    _loadExpenses();
  }

  void _initializeUser() async {
    _user = (await _userService.loadUser()) ?? User(saldo: 0);
  }

  void setUser(User user) {
    _user = user;
    _loadExpenses();
    notifyListeners();
  }

  List<Expense> get expensesList => [..._expenses];

  double? get saldo => _user.saldo;

  set selecionado(Expense? val) {
    _selecionado = val;
    notifyListeners();
  }

  set idx(int? val) {
    _idx = val;
    notifyListeners();
  }

  Future<void> _loadExpenses() async {
    _expenses = await _expenseService.loadExpenses();
  }

  void _saveExpenses() async {
    await _expenseService.saveExpenses(_expenses);
    await _userService.saveSaldo(_user.saldo);
  }

  Future<void> _updateSaldo(double amount) async {
    double newSaldo = (_user.saldo - amount);
    if (newSaldo < 0) {
      newSaldo = 0;
    } else if (amount > _user.saldo) {
      newSaldo = _user.saldo;
    }
    _user.saldo = newSaldo;
    await _userService.saveUser(_user);
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await _updateSaldo(expense.amount);
    _saveExpenses();
    notifyListeners();
  }

  double? deleteExpense(Expense expense, idx) {
    double returnAmount = _user.saldo + expense.amount;
    _updateSaldo(returnAmount);
    _user.saldo = returnAmount;
    _expenses.removeAt(idx);
    _saveExpenses();
    notifyListeners();
    return returnAmount;
  }

  void editExpense(
    Expense expense,
    ExpenseCategory category,
    double amount,
    DateTime date,
  ) {
    _updateSaldo(-expense.amount);

    final editedExpense = Expense(
      id: expense.id,
      name: expense.name,
      category: category,
      amount: amount,
      date: date,
    );

    _expenses[_expenses.indexOf(expense)] = editedExpense;

    _updateSaldo(amount);
    _saveExpenses();
    notifyListeners();
  }

  List<Expense> getExpensesByCategory(String category) {
    final ExpenseCategory expenseCategory = Expense.parseExpenseCategory(category);
    return _expenses.where((expense) => expense.category == expenseCategory).toList();
  }
}
