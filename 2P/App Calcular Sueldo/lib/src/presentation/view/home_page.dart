import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad 2.1 App Calc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Indicaciones',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Botón para Pantalla 1
            ElevatedButton.icon(
              icon: const Icon(Icons.calculate),
              label: const Text('Pantalla 1: Calcular Aumento'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.calculateIncrease);
              },
            ),
            const SizedBox(height: 16),
            // Botón para Pantalla 2
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text('Pantalla 2: Historial'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.history);
              },
            ),
            const SizedBox(height: 16),
            // Botón para Pantalla 3
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Pantalla 3: Reporte PDF'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.pdfReport);
              },
            ),
          ],
        ),
      ),
    );
  }
}
