import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

/// MOLECULE: Selector de familia con diseño elegante
class FamilyFilter extends StatelessWidget {
  final String? selectedFamily;
  final List<String> families;
  final ValueChanged<String?> onFamilyChanged;

  const FamilyFilter({
    super.key,
    required this.selectedFamily,
    required this.families,
    required this.onFamilyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceColor.withOpacity(0.6),
            AppTheme.surfaceColor.withOpacity(0.4),
          ],
        ),
        borderRadius: AppTheme.smallRadius,
        border: Border.all(
          color: AppTheme.goldColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: selectedFamily,
          hint: Row(
            children: [
              Icon(
                Icons.filter_list,
                size: 18,
                color: AppTheme.goldColor.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                'Todas las casas',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.goldColor,
          ),
          dropdownColor: AppTheme.cardColor,
          borderRadius: AppTheme.mediumRadius,
          style: AppTheme.bodyMedium.copyWith(color: AppTheme.textPrimary),
          isExpanded: true,
          items: [
            DropdownMenuItem<String?>(
              value: null,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.all_inclusive,
                      size: 14,
                      color: AppTheme.accentColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Todas las casas'),
                ],
              ),
            ),
            ...families.map((family) => DropdownMenuItem<String>(
              value: family,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _getFamilyColor(family).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.shield,
                      size: 14,
                      color: _getFamilyColor(family),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      family.length > 20 ? '${family.substring(0, 17)}...' : family,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )),
          ],
          onChanged: onFamilyChanged,
        ),
      ),
    );
  }

  Color _getFamilyColor(String family) {
    final familyLower = family.toLowerCase();
    if (familyLower.contains('stark')) return const Color(0xFF607D8B);
    if (familyLower.contains('lannister')) return const Color(0xFFD4AF37);
    if (familyLower.contains('targaryen')) return const Color(0xFFE94560);
    if (familyLower.contains('baratheon')) return const Color(0xFFFFC107);
    if (familyLower.contains('greyjoy')) return const Color(0xFF37474F);
    if (familyLower.contains('tyrell')) return const Color(0xFF4CAF50);
    if (familyLower.contains('martell')) return const Color(0xFFFF9800);
    return AppTheme.accentColor;
  }
}
