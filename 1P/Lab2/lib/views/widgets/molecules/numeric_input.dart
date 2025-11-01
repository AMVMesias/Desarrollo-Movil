import 'package:flutter/material.dart';
import 'package:laboratorio2/views/widgets/atoms/caja_texto.dart';
import 'package:laboratorio2/utils/input_validator.dart';

enum NumericInputType { integer, decimal }

/// Molécula: Input numérico con validación integrada
class NumericInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final NumericInputType type;
  final int decimalRange;
  final AutovalidateMode autovalidateMode;
  final void Function(String)? onChanged;

  const NumericInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.type = NumericInputType.integer,
    this.decimalRange = 2,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final keyboard = type == NumericInputType.integer
        ? TextInputType.number
        : const TextInputType.numberWithOptions(decimal: true);

    // Selecciona validador según tipo: entero o decimal
    final validator = type == NumericInputType.integer
        ? InputValidator.validateNonNegativeInteger
        : InputValidator.validateNonNegativeDecimal;

    return CajaTexto(
      controller: controller,
      label: label,
      hint: hint,
      keyboardType: keyboard,
      validator: validator,
      autovalidateMode: autovalidateMode,
      maxLines: 1,
    );
  }
}
