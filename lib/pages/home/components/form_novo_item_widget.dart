import 'package:flutter/material.dart';
import 'package:myexpenses/components/spacer_component.dart';
import 'package:provider/provider.dart';

import '../../../entities/expense.dart';
import '../../../providers/user_provider.dart';
import 'alert_balance.dart';

class FormNovoItemWidget extends StatefulWidget {
  final ValueChanged<Expense> onExpenseChanged;
  const FormNovoItemWidget({super.key, required this.onExpenseChanged});

  @override
  State<FormNovoItemWidget> createState() => _FormNovoItemWidgetState();
}

class _FormNovoItemWidgetState extends State<FormNovoItemWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.diversas;
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome da despesa';
              }
              return null;
            },
          ),
          DropdownButtonFormField<ExpenseCategory>(
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            items: ExpenseCategory.values.map((category) {
              return DropdownMenuItem<ExpenseCategory>(
                value: category,
                child: Text(category.toString().split('.').last),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: 'Categoria',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Valor',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o valor da despesa';
              }
              if (double.tryParse(value) == null) {
                return 'Valor inválido';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _amount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SpacerComponent(),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final expense = Expense(
                  name: _titleController.text,
                  id: DateTime.now().toString(),
                  category: _selectedCategory,
                  amount: _amount,
                  date: DateTime.now(),
                );
                if (_amount >
                    Provider.of<UserProvider>(context, listen: false)
                        .user!
                        .saldo
                        .toDouble()) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertBalance();
                    },
                  );
                } else {
                  widget.onExpenseChanged(expense);
                }
              }
            },
            child: const Text('Cadastrar Despesa'),
          ),
        ],
      ),
    );
  }
}
