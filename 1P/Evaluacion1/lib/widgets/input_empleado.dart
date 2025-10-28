import 'package:flutter/material.dart';

// Átomo
class InputEmpleado extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const InputEmpleado({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
