import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myexpenses/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import '../../components/body_component.dart';
import '../../providers/user_provider.dart';
import 'abas/chart_tab.dart';
import 'abas/expense_tab.dart';
import 'abas/perfil_tab.dart';
import 'components/form_novo_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserProvider storeUser;
  late ExpenseProvider storeExpense;
  late int abaSelecionada;
  List<BarChartGroupData> chartData = [];

  void handleTab(int tabIdx) {
    setState(() {
      abaSelecionada = tabIdx;
    });
  }

  @override
  void initState() {
    abaSelecionada = 0;
    storeExpense = Provider.of<ExpenseProvider>(context, listen: false);
    storeUser = Provider.of<UserProvider>(context, listen: false);
    storeUser.init().then((value) {
      if (storeUser.user != null) {
        storeExpense.setUser(storeUser.user!);
      }
    });

    super.initState();
  }

  final List<BottomNavigationBarItem> _abas = [const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), const BottomNavigationBarItem(icon: Icon(Icons.bar_chart_sharp), label: 'Gráfico'), const BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Perfil')];

  @override
  Widget build(BuildContext context) {
    final expenses = storeExpense.expensesList;

    final List<Widget> _conteudos = [
      const ExpenseTab(),
      ChartTab(
        expenses: expenses,
      ),
      const PerfilTab(),
    ];
    return BodyComponent(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      bar: BottomNavigationBar(
        currentIndex: abaSelecionada,
        items: _abas,
        onTap: handleTab,
      ),
      actionButton: FloatingActionButton(
        onPressed: () {
          abrirModalCadastro(context);
        },
        child: const Icon(Icons.add),
      ),
      child: _conteudos.elementAt(abaSelecionada),
    );
  }

  void abrirModalCadastro(BuildContext context) {
    final nav = Navigator.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(16),
          children: [
            FormNovoItemWidget(onExpenseChanged: (item) async {
              await storeExpense.addExpense(item);
              storeUser.updateSaldo(storeExpense.saldo ?? 0.00);
              nav.pop();
            }),
          ],
        );
      },
    );
  }
}
