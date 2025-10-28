import 'package:flutter/material.dart';
import '../controller/empleado_controller.dart';
import '../widgets/input_empleado.dart';
import '../widgets/boton_calcular.dart';

// Moléculas
class EmpleadoInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const EmpleadoInput({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputEmpleado(controller: controller, label: label),
        SizedBox(height: 10.0),
      ],
    );
  }
}

// Organismo
class EmpleadoCard extends StatefulWidget {
  EmpleadoCard({super.key});

  @override
  State<EmpleadoCard> createState() => _EmpleadoCardState();
}

class _EmpleadoCardState extends State<EmpleadoCard> {
  final EmpleadoController controller = EmpleadoController();
  final TextEditingController edadCtrl = TextEditingController();
  final TextEditingController antiguedadCtrl = TextEditingController();

  void _calcular() {
    final resultado = controller.calcularSueldo(edadCtrl.text, antiguedadCtrl.text);
    Navigator.pushNamed(context, '/resultado', arguments: resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            EmpleadoInput(controller: edadCtrl, label: "Edad del empleado"),
            EmpleadoInput(controller: antiguedadCtrl, label: "Años en la empresa"),
            SizedBox(height: 10.0),
            BotonCalcular(onPressed: _calcular),
          ],
        ),
      ),
    );
  }
}

// Página
class PaginaView extends StatelessWidget {
  PaginaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcular Sueldo Empleado"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: EmpleadoCard(),
      ),
    );
  }
}
