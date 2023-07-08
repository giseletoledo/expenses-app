import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myexpenses/entities/category_data.dart';

import '../../../entities/expense.dart';

class ChartTab extends StatelessWidget {
  const ChartTab({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final chartData = getCategoryData(expenses);

    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BarChart(
                BarChartData(
                  barGroups: getBarGroups(chartData),
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(width: 1),
                      left: BorderSide(width: 1),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 30, showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 30, showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: _getBottomTitles(chartData),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> getBarGroups(List<CategoryData> data) {
    final List<BarChartGroupData> barGroups = [];

    for (var i = 0; i < data.length; i++) {
      final categoryData = data[i];
      final barGroup = BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: categoryData.count.toDouble(),
            color: getCategoryColor(categoryData.category),
          ),
        ],
      );

      barGroups.add(barGroup);
    }

    return barGroups;
  }

  String getCategoryLabel(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.alimentacao:
        return 'Alimentação';
      case ExpenseCategory.vestuario:
        return 'Vestuário';
      case ExpenseCategory.lazer:
        return 'Lazer';
      default:
        return 'Diversas';
    }
  }

  SideTitles _getBottomTitles(List<CategoryData> chartData) {
    String labelTextValue = '';
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, _) {
        final index = value.toInt();
        if (index >= 0 && index < chartData.length) {
          final category = chartData[index].category;
          final labelText = getCategoryLabel(category);
          labelTextValue = labelText;
        }
        return Text(labelTextValue); // Retorna o labelText
      },
    );
  }

  // Função para obter a cor da categoria
  Color getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.alimentacao:
        return Colors.blue;
      case ExpenseCategory.vestuario:
        return Colors.red;
      case ExpenseCategory.lazer:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
