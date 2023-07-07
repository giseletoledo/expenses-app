import 'package:flutter/material.dart';

class AlertBalance extends StatelessWidget {
  const AlertBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Saldo Insuficiente'),
      content:
          const Text('O valor da despesa é maior do que o saldo disponível.'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
