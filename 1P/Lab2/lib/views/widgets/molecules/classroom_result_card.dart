import 'package:flutter/material.dart';
import '../../../models/classroom.dart';

/// Molécula: Tarjeta que muestra el promedio de edad de un salón
class ClassroomResultCard extends StatelessWidget {
  final Classroom classroom;

  const ClassroomResultCard({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFDB813).withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          '${classroom.name}: ${classroom.averageAge.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
