import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/operario_viewmodel.dart';
import '../widgets/organisms/salary_calculator_form.dart';
import '../widgets/molecules/info_card.dart';

class CalculateIncreaseScreen extends StatelessWidget {
  const CalculateIncreaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer para escuchar cambios en el ViewModel
    return Consumer<OperarioViewModel>(
      builder: (context, viewModel, child) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Calcular Aumento'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Formulario para calcular
                SalaryCalculatorForm(
                  onCalculate: (salary, antiguedad) {
                    // El ViewModel se encarga de calcular y notificar a los listeners
                    viewModel.calcular(salary, antiguedad);
                  },
                ),
                const SizedBox(height: 32),

                const Divider(thickness: 1),
                const SizedBox(height: 32),
                
                // Sección de Resultado
                Text(
                  'Resultado',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                
                // Muestra el resultado si ya se ha calculado
                if (viewModel.resultado != null)
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          InfoCard(
                            title: 'Aumento Salarial',
                            value: '\$ ${viewModel.resultado!.aumento.toStringAsFixed(2)}',
                            icon: Icons.trending_up,
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(height: 16),
                          InfoCard(
                            title: 'Salario Final',
                            value: '\$ ${viewModel.resultado!.sueldoFinal.toStringAsFixed(2)}',
                            icon: Icons.account_balance_wallet,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  const Center(
                    child: Text('Ingrese los datos para ver el resultado.'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
