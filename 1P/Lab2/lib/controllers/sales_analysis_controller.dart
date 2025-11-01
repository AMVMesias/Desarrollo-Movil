import '../models/sales_analysis_model.dart';

// Ejercicio 4.13
class SalesAnalysisController {
  SalesAnalysisResult? analizarDesdeTexto(String input) {
    if (input.trim().isEmpty) return null; // Valida: no vacío

    final parts = input.split(RegExp(r'[,\n\r]+'));
    final values = <double>[];

    for (final p in parts) {
      final s = p.trim();
      if (s.isEmpty) continue; // Ignora partes vacías
      final n = double.tryParse(s.replaceAll(RegExp(r',\s*'), ''));
      if (n != null) {
        values.add(n);
      }
    }

    if (values.isEmpty) return null; // Valida: al menos un valor

    return SalesAnalysisResult.analyze(values);
  }
}
