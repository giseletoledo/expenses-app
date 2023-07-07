import 'package:flutter/material.dart';

import 'palette_style.dart';

class PaletteLight implements PaletteStyle {
  @override
  Color primary = Colors.deepPurple;

  @override
  Color accent = const Color.fromARGB(255, 196, 168, 245);

  @override
  Color background = const Color.fromARGB(255, 228, 219, 255);

  @override
  Color backgroundDark = const Color.fromARGB(255, 29, 4, 57);

  @override
  Color error = Colors.red;

  @override
  Color primaryDark = const Color.fromARGB(255, 116, 28, 131);

  @override
  Color secondary = const Color.fromARGB(255, 145, 80, 237);

  @override
  Color success = Colors.green;

  @override
  Color text = Colors.black87;

  @override
  Color textSecondary = Colors.black;

  @override
  Color warning = Colors.yellow[700]!;

  @override
  Color white = Colors.white;
}
