import 'package:flutter/material.dart';
import '../atoms/custom_text_field.dart';
import '../atoms/custom_button.dart';
import '../molecules/radio_button_group.dart';

/// Organismo: Formulario de cálculo de salario
class SalaryCalculatorForm extends StatefulWidget {
  final Function(double salary, int antiguedad) onCalculate;

  const SalaryCalculatorForm({
    super.key,
    required this.onCalculate,
  });

  @override
  State<SalaryCalculatorForm> createState() => _SalaryCalculatorFormState();
}

class _SalaryCalculatorFormState extends State<SalaryCalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  final _salaryController = TextEditingController();
  int _selectedAntiguedad = 1;

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  void _handleCalculate() {
    if (_formKey.currentState!.validate()) {
      final salary = double.parse(_salaryController.text);
      widget.onCalculate(salary, _selectedAntiguedad);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de salario
          CustomTextField(
            label: 'Salario Actual',
            hint: 'Ingrese su salario',
            controller: _salaryController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un salario';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor ingrese un número válido';
              }
              if (double.parse(value) <= 0) {
                return 'El salario debe ser mayor a 0';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Grupo de radio buttons
          RadioButtonGroup(
            selectedValue: _selectedAntiguedad,
            onChanged: (value) {
              setState(() {
                _selectedAntiguedad = value ?? 1;
              });
            },
          ),
          const SizedBox(height: 32),

          // Botón de calcular
          CustomButton(
            text: 'Calcular Aumento',
            onPressed: _handleCalculate,
          ),
        ],
      ),
    );
  }
}
