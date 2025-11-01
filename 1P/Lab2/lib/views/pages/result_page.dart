import 'package:flutter/material.dart';

/// Página: Muestra resultado genérico
class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final String resultado =
      (args is String && args.isNotEmpty) ? args : (args?.toString() ?? 'N/A');

    return Scaffold(
      appBar: AppBar( 
        title: const Text('Resultado'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Resultado: $resultado',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
