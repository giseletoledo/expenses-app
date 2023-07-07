import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myexpenses/components/spacer_component.dart';
import 'package:myexpenses/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import 'components/custom_text_rich.dart';

class DetalhePage extends StatefulWidget {
  const DetalhePage({super.key});

  @override
  State<DetalhePage> createState() => _DetalhePageState();
}

class _DetalhePageState extends State<DetalhePage> {
  late ExpenseProvider expense;
  int? idx;
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ExpenseProvider>(context);
    final index = store.idx;
    final item = store.selecionado;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Despesa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextRich(
              label: 'Nome:',
              value: item?.name ?? 'Nome não disponível',
            ),
            const SpacerComponent(),
            customTextRich(
              label: 'Categoria:',
              value: item?.category.toString().split('.').last ??
                  'Valor não disponível',
            ),
            const SpacerComponent(),
            customTextRich(
              label: 'Valor:',
              value: 'R\$ ${item?.amount.toStringAsFixed(2)}',
            ),
            const SpacerComponent(),
            customTextRich(
              label: 'Data:',
              value: item != null
                  ? DateFormat('dd/MM/yyyy HH:mm').format(item.date)
                  : 'Data não disponível',
            ),
          ],
        ),
      ),
    );
  }
}
