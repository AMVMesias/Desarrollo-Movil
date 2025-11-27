import 'package:flutter/material.dart';
import '../../domain/entities/resultado_operario.dart';
import '../widgets/molecules/info_card.dart';
import '../widgets/atoms/custom_button.dart';

class ResultadoPage extends StatelessWidget {
  final ResultadoOperario resultado;

  const ResultadoPage({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado del Cálculo',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icono de éxito
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withAlpha(51),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Título
              Text(
                '¡Cálculo Completado!',
                textAlign: TextAlign.center,
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Aquí está el detalle de tu aumento salarial',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Tarjeta de aumento
              InfoCard(
                title: 'Aumento Salarial',
                value: '\$ ${resultado.aumento.toStringAsFixed(2)}',
                icon: Icons.trending_up,
                color: colorScheme.secondary,
              ),
              const SizedBox(height: 16),

              // Tarjeta de salario final
              InfoCard(
                title: 'Salario Final',
                value: '\$ ${resultado.sueldoFinal.toStringAsFixed(2)}',
                icon: Icons.account_balance_wallet,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 32),

              // Información adicional
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary.withAlpha(26), colorScheme.secondary.withAlpha(26)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorScheme.primary.withAlpha(77)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.celebration,
                      size: 40,
                      color: colorScheme.secondary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '¡Felicidades!',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tu dedicación y antigüedad han sido reconocidas con este aumento',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Botones de acción
              CustomButton(
                text: 'Hacer Nuevo Cálculo',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: colorScheme.primary,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Volver al Inicio',
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                backgroundColor: colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
