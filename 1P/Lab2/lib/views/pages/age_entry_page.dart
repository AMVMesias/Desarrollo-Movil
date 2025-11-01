import 'package:flutter/material.dart';

/// Página: Ingreso de edades de estudiantes por salón
class AgeEntryPage extends StatefulWidget {
  final String classroomName;
  final int numberOfStudents;

  const AgeEntryPage({
    super.key,
    required this.classroomName,
    required this.numberOfStudents,
  });

  @override
  _AgeEntryPageState createState() => _AgeEntryPageState();
}

class _AgeEntryPageState extends State<AgeEntryPage> {
  late final List<TextEditingController> _controllers;
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.numberOfStudents,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _saveAges() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final List<int> ages = [];
      for (var controller in _controllers) {
        ages.add(int.parse(controller.text));
      }
      Navigator.of(context).pop(ages);
    } else {
      setState(() {
        _errorMessage = 'Por favor, corrige los errores antes de continuar.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edades para ${widget.classroomName}'),
        backgroundColor: const Color(0xFFFDB813),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              // Usamos un ListView para que la lista de campos sea desplazable
              // si hay muchos alumnos.
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: widget.numberOfStudents,
                itemBuilder: (context, index) {
                  // MOLÉCULA: Cada fila es una molécula que combina un
                  // ícono (átomo) y un campo de texto (átomo).
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        labelText: 'Edad del Alumno ${index + 1}',
                        icon: const Icon(Icons.person),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No puede estar vacío';
                        }
                        final age = int.tryParse(value);
                        if (age == null) {
                          return 'Debe ser un número';
                        }
                        if (age < 7) {
                          return 'La edad debe ser 7 o mayor';
                        }
                        return null;
                      },
                    ),
                  );
                },
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveAges,
        label: const Text('Guardar Edades'),
        icon: const Icon(Icons.save),
        backgroundColor: const Color(0xFFFDB813),
      ),
    );
  }
}
