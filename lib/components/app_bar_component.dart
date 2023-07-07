import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const AppBarComponent({super.key, this.titulo = 'Minhas despesas'});

  static Size get size => const Size.fromHeight(kToolbarHeight);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 174, 139, 235),
      title: Text(titulo),
      actions: const [],
    );
  }
}
