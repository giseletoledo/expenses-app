import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ExpenseCategory {
  alimentacao,
  vestuario,
  lazer,
  diversas,
}

class Expense {
  final String id;
  final String name;
  final ExpenseCategory category;
  final double amount;
  final DateTime date;

  Expense({
    required this.name,
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
  });

  String get formattedAmount {
    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return currencyFormat.format(amount);
  }

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        category = parseExpenseCategory(json['category']),
        amount = json['amount'].toDouble(),
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.toString().split('.').last,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  static ExpenseCategory parseExpenseCategory(String category) {
    switch (category.toLowerCase()) {
      case 'alimentação':
        return ExpenseCategory.alimentacao;
      case 'vestuário':
        return ExpenseCategory.vestuario;
      case 'lazer':
        return ExpenseCategory.lazer;
      default:
        return ExpenseCategory.diversas;
    }
  }

  IconData getCategoryIcon(category) {
    switch (category) {
      case ExpenseCategory.alimentacao:
        return Icons.restaurant;
      case ExpenseCategory.vestuario:
        return Icons.shopping_bag;
      case ExpenseCategory.lazer:
        return Icons.deck;
      default:
        return Icons.question_mark;
    }
  }

  static List<Expense> fromJsonList(List<dynamic>? json) {
    return json?.map((item) => Expense.fromJson(item)).toList() ?? [];
  }
}
