import 'package:flutter/material.dart';

/// Página: Muestra resultados de inversión anual
class InvestmentResultsView extends StatelessWidget {
  final List<double> results;

  const InvestmentResultsView({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la Inversión'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                'Año ${index + 1}',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '\$${results[index].toStringAsFixed(2)}',
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
