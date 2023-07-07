import 'package:flutter/material.dart';

Widget customTextRich({required String label, required String value}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '$label ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    ),
  );
}
