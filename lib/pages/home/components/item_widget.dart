import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myexpenses/entities/expense.dart';

import '../../../components/icon_button_component.dart';
import '../../../components/spacer_component.dart';

class ItemWidget extends StatelessWidget {
  final Expense item;
  final VoidCallback onPressed;

  const ItemWidget({
    Key? key,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const SpacerComponent(isHorizontal: true),
            Icon(
              item.getCategoryIcon(item.category),
              size: 24,
              color: const Color.fromARGB(255, 163, 123, 238),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.formattedAmount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              DateFormat('dd/MM/yyyy').format(item.date),
              style: const TextStyle(fontSize: 14),
            ),
            const SpacerComponent(isFull: true),
            IconButtonComponent(
              icon: Icons.arrow_forward_ios,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
