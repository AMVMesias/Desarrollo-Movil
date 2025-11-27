import 'package:flutter/material.dart';
import '../atoms/custom_radio_option.dart';

/// Molécula: Grupo de opciones de radio buttons
class RadioButtonGroup extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int?> onChanged;

  const RadioButtonGroup({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Años de Antigüedad',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        CustomRadioOption<int>(
          value: 1,
          groupValue: selectedValue,
          label: 'Menos de 2 años',
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
        CustomRadioOption<int>(
          value: 2,
          groupValue: selectedValue,
          label: '2 a 4 años',
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
        CustomRadioOption<int>(
          value: 5,
          groupValue: selectedValue,
          label: '5 a 9 años',
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
        CustomRadioOption<int>(
          value: 10,
          groupValue: selectedValue,
          label: '10 años o más',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
