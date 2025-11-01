import 'package:flutter/material.dart';
import 'dart:async';

import '../../controllers/school_controller.dart';
import '../../models/classroom.dart';
import '../../models/student.dart';
import '../widgets/molecules/classroom_result_card.dart';
import 'age_entry_page.dart';

/// Página: Cálculo de promedios de edad por salón (Ejercicio 4.10)
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _schoolController = SchoolController();
  Widget _resultsWidget = const SizedBox.shrink();

  Future<void> _startDataEntry() async {
    _schoolController.clearData();
    setState(() {
      _resultsWidget = const SizedBox.shrink();
    });

    final int? numberOfClassrooms = await _showInputDialog(
      title: 'Paso 1: Salones',
      label: 'Número de salones de clase',
      validation: (value) => value > 0 ? null : 'Debe ser mayor a 0',
    );
    if (numberOfClassrooms == null) return;

    for (int i = 0; i < numberOfClassrooms; i++) {
      final String? classroomName = await _showInputDialog(
        title: 'Salón ${i + 1}/${numberOfClassrooms}',
        label: 'Nombre del salón (ej: Salón A)',
        isNumeric: false,
      );
      if (classroomName == null) return;

      final int? numberOfStudents = await _showInputDialog(
        title: 'Salón \'$classroomName\'',
        label: 'Número de alumnos',
        validation: (value) => value > 0 ? null : 'Debe ser mayor a 0',
      );
      if (numberOfStudents == null) return;

      final List<int>? ages = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgeEntryPage(
            classroomName: classroomName,
            numberOfStudents: numberOfStudents,
          ),
        ),
      );

      if (ages == null) return;

      final List<Student> students = [];
      for (int j = 0; j < ages.length; j++) {
        students.add(Student(name: 'Alumno ${j + 1}', age: ages[j]));
      }

      _schoolController.addClassroom(
        Classroom(name: classroomName, students: students),
      );
    }

    _buildResults();
  }

  void _buildResults() {
    setState(() {
      _resultsWidget = Column(
        children: [
          Text(
            'Promedio General de la Escuela: ${_schoolController.overallAverageAge.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ..._schoolController.classrooms.map(
            (classroom) => ClassroomResultCard(classroom: classroom),
          ),
        ],
      );
    });
  }

  Future<T?> _showInputDialog<T>(
      {required String title,
      required String label,
      bool isNumeric = true,
      String? Function(T)? validation}) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(labelText: label),
            autofocus: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (isNumeric) {
                final number = int.tryParse(value);
                if (number == null) {
                  return 'Debe ser un número válido';
                }
                if (validation != null) {
                  return validation(number as T);
                }
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(controller.text);
              }
            },
          ),
        ],
      ),
    );

    if (result == null) return null;
    return (isNumeric ? int.tryParse(result) : result) as T?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escuela San Felipe'),
        backgroundColor: const Color(0xFFFDB813),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF003366),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _resultsWidget,
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _startDataEntry,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  child: const Text('Calcular Promedios', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
