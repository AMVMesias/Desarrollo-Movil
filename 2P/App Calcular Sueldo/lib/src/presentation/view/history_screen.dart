import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/operario_viewmodel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer para obtener los datos del ViewModel
    return Consumer<OperarioViewModel>(
      builder: (context, viewModel, child) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Historial de Cálculos'),
          ),
          // Muestra un mensaje si el historial está vacío
          body: viewModel.historial.isEmpty
              ? const Center(
                  child: Text(
                    'Aún no has realizado ningún cálculo.',
                    textAlign: TextAlign.center,
                  ),
                )
              // Muestra la lista de cálculos
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: viewModel.historial.length,
                  itemBuilder: (context, index) {
                    final resultado = viewModel.historial[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primary,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: theme.colorScheme.onPrimary),
                          ),
                        ),
                        title: Text('Salario Final: \$ ${resultado.sueldoFinal.toStringAsFixed(2)}'),
                        subtitle: Text('Aumento: \$ ${resultado.aumento.toStringAsFixed(2)}'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
