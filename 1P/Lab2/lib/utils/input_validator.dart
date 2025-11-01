// Utilidad: Validaciones de entrada
class InputValidator {
  InputValidator._();

  // Valida entero no negativo (null, vacío o >=0)
  static String? validateNonNegativeInteger(String? value) {
    if (value == null) return null;
    final t = value.trim();
    if (t.isEmpty) return null;
    final parsed = int.tryParse(t);
    if (parsed == null || parsed < 0) return 'Entero inválido';
    return null;
  }

  // Parsea entero no negativo, retorna 0 si inválido
  static int parseQtyOrZero(String? value) {
    if (value == null) return 0;
    final t = value.trim();
    if (t.isEmpty) return 0;
    final parsed = int.tryParse(t);
    if (parsed == null || parsed < 0) return 0;
    return parsed;
  }

  // Valida decimal no negativo (null, vacío o >=0)
  static String? validateNonNegativeDecimal(String? value) {
    if (value == null) return null;
    final t = value.trim();
    if (t.isEmpty) return null;
    final normalized = t.replaceAll(',', '.');
    final v = double.tryParse(normalized);
    if (v == null || v < 0) return 'Número inválido';
    return null;
  }

  // Parsea decimal no negativo, retorna 0.0 si inválido
  static double parseDoubleOrZero(String? value) {
    if (value == null) return 0.0;
    final t = value.trim();
    if (t.isEmpty) return 0.0;
    final normalized = t.replaceAll(',', '.');
    final v = double.tryParse(normalized);
    if (v == null || v.isNaN || v.isInfinite || v < 0) return 0.0;
    return v;
  }
}
