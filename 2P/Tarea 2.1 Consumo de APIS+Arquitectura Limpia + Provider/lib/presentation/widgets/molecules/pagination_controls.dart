import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';
import '../atoms/custom_button.dart';

/// MOLECULE: Controles de paginación con diseño elegante
class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.backgroundColor.withOpacity(0.8),
            AppTheme.backgroundColor,
          ],
        ),
        border: Border(
          top: BorderSide(
            color: AppTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Botón anterior
            CustomButton(
              icon: Icons.chevron_left,
              text: 'Anterior',
              onPressed: hasPrevious ? onPrevious : null,
              isEnabled: hasPrevious,
              type: ButtonType.outline,
              width: 120,
            ),
            // Indicador de página
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: AppTheme.smallRadius,
                border: Border.all(
                  color: AppTheme.goldColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '${currentPage + 1}',
                    style: AppTheme.headingMedium.copyWith(
                      color: AppTheme.goldColor,
                    ),
                  ),
                  Text(
                    ' / $totalPages',
                    style: AppTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            // Botón siguiente
            CustomButton(
              text: 'Siguiente',
              icon: Icons.chevron_right,
              onPressed: hasNext ? onNext : null,
              isEnabled: hasNext,
              type: ButtonType.primary,
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}
