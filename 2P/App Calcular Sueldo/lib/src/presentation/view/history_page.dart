import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/operario_viewmodel.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OperarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Cálculos'),
      ),
      body: ListView.builder(
        itemCount: viewModel.historial.length,
        itemBuilder: (context, index) {
          final resultado = viewModel.historial[index];
          return ListTile(
            title: Text('Sueldo Final: S/ ${resultado.sueldoFinal.toStringAsFixed(2)}'),
            subtitle: Text('Aumento: S/ ${resultado.aumento.toStringAsFixed(2)}'),
            trailing: const Icon(Icons.history),
          );
        },
      ),
    );
  }
}
