import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/operario_viewmodel.dart';

class PdfReportPage extends StatelessWidget {
  const PdfReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OperarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte en PDF'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.historial.length,
              itemBuilder: (context, index) {
                final resultado = viewModel.historial[index];
                return ListTile(
                  title: Text('Sueldo Final: S/ ${resultado.sueldoFinal.toStringAsFixed(2)}'),
                  subtitle: Text('Aumento: S/ ${resultado.aumento.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Simulando generación de PDF...')),
                );
              },
              child: const Text('Generar PDF'),
            ),
          ),
        ],
      ),
    );
  }
}
