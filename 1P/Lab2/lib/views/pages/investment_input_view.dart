import 'package:flutter/material.dart';
import '../../controllers/investment_controller.dart';
import '../widgets/atoms/custom_text_field.dart';
import '../widgets/atoms/custom_button.dart';
import 'investment_results_view.dart';

/// Página: Entrada de datos para cálculo de inversión
class InvestmentInputView extends StatefulWidget {
  const InvestmentInputView({Key? key}) : super(key: key);

  @override
  _InvestmentInputViewState createState() => _InvestmentInputViewState();
}

class _InvestmentInputViewState extends State<InvestmentInputView> {
  final _formKey = GlobalKey<FormState>();
  final _monthlyDepositController = TextEditingController();
  final _yearsController = TextEditingController();
  final _investmentController = InvestmentController();

  void _calculateInvestment() {
    if (_formKey.currentState!.validate()) {
      final double monthlyDeposit = double.parse(_monthlyDepositController.text);
      final int years = int.parse(_yearsController.text);

      _investmentController.setInvestmentData(
        monthlyDeposit: monthlyDeposit,
        years: years,
      );

      final results = _investmentController.calculateYearlyInvestment();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvestmentResultsView(results: results),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Inversión'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _monthlyDepositController,
                labelText: 'Depósito Mensual',
                keyboardType: TextInputType.number,
                // Valida: no null, no vacío, número válido, > 0
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un valor';
                  }
                  final n = double.tryParse(value);
                  if (n == null) {
                    return 'Por favor, ingrese un número válido';
                  }
                  if (n <= 0) {
                    return 'El valor debe ser positivo y distinto de cero';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _yearsController,
                labelText: 'Cantidad de Años',
                keyboardType: TextInputType.number,
                // Valida: no null, no vacío, entero válido, > 0
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un valor';
                  }
                  final n = int.tryParse(value);
                  if (n == null) {
                    return 'Por favor, ingrese un número entero válido';
                  }
                  if (n <= 0) {
                    return 'El valor debe ser positivo y distinto de cero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: _calculateInvestment,
                text: 'Calcular',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
