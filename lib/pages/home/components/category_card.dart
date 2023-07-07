import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 171, 2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          icon: Icon(icon),
          color: isSelected ? color : Colors.white,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
