import 'package:flutter/material.dart';

class AddMealButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddMealButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('Add Meal'),
    );
  }
}
