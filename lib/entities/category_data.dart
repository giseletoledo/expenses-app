import 'expense.dart';

class CategoryData {
  final ExpenseCategory category;
  final int count;

  CategoryData({
    required this.category,
    required this.count,
  });
}

List<CategoryData> getCategoryData(List<Expense> expenses) {
  final Map<ExpenseCategory, int> categoryCounts = {};

  for (var expense in expenses) {
    final category = expense.category;
    categoryCounts.update(
      category,
      (value) => value + 1,
      ifAbsent: () => 1,
    );
  }

  final data = categoryCounts.entries.map((entry) {
    return CategoryData(
      category: entry.key,
      count: entry.value,
    );
  }).toList();

  return data;
}
