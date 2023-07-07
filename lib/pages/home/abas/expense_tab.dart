import 'package:flutter/material.dart';
import 'package:myexpenses/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import '../../../app_routes.dart';
import '../../../entities/expense.dart';
import '../../../providers/user_provider.dart';
import '../components/card_balance_component.dart';
import '../components/category_card.dart';
import '../components/form_novo_item_widget.dart';
import '../components/item_widget.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ExpenseTab();
}

class _ExpenseTab extends State<ExpenseTab> {
  late ExpenseProvider providerStore;
  late UserProvider userStore;
  ExpenseCategory? selectedCategory;

  void onDetalhes(Expense item, int idx) {
    providerStore.selecionado = item;
    providerStore.idx = idx;
    Navigator.pushNamed(context, AppRoutes.detalhe);
  }

  @override
  Widget build(BuildContext context) {
    providerStore = Provider.of<ExpenseProvider>(context);
    userStore = Provider.of<UserProvider>(context);

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CardBalanceComponent(userStore: userStore),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CategoryCard(
              icon: Icons.format_list_bulleted,
              color: Colors.deepPurple,
              isSelected: selectedCategory == null,
              onPressed: () {
                setState(() {
                  selectedCategory = null;
                });
              },
            ),
            CategoryCard(
              icon: Icons.deck,
              color: Colors.deepPurple,
              isSelected: selectedCategory == ExpenseCategory.lazer,
              onPressed: () {
                setState(() {
                  selectedCategory = ExpenseCategory.lazer;
                });
              },
            ),
            CategoryCard(
              icon: Icons.question_mark,
              color: Colors.deepPurple,
              isSelected: selectedCategory == ExpenseCategory.diversas,
              onPressed: () {
                setState(() {
                  selectedCategory = ExpenseCategory.diversas;
                });
              },
            ),
            CategoryCard(
              icon: Icons.restaurant,
              color: Colors.deepPurple,
              isSelected: selectedCategory == ExpenseCategory.alimentacao,
              onPressed: () {
                setState(() {
                  selectedCategory = ExpenseCategory.alimentacao;
                });
              },
            ),
            CategoryCard(
              icon: Icons.shopping_bag,
              color: Colors.deepPurple,
              isSelected: selectedCategory == ExpenseCategory.vestuario,
              onPressed: () {
                setState(() {
                  selectedCategory = ExpenseCategory.vestuario;
                });
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: providerStore.expensesList.length,
            itemBuilder: (context, index) {
              final item = providerStore.expensesList.elementAt(index);
              if (selectedCategory != null &&
                  item.category != selectedCategory) {
                return Container(); // Retorna um widget vazio para ocultar a despesa
              }

              return Dismissible(
                key: Key(item.id),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd ||
                      direction == DismissDirection.endToStart) {
                    handleExcluir(item, index);
                  }
                },
                child: ItemWidget(
                  item: item,
                  onPressed: () {
                    onDetalhes(item, index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void handleAdicionar() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(16.0),
          children: [
            FormNovoItemWidget(onExpenseChanged: (item) async {
              providerStore.addExpense(item);
              userStore.updateSaldo(providerStore.saldo ?? 0.00);
            }),
          ],
        );
      },
    );
  }

  void handleExcluir(Expense item, int idx) {
    final saldo = providerStore.deleteExpense(item, idx);
    userStore.updateSaldo(saldo ?? 0.0);
  }
}
