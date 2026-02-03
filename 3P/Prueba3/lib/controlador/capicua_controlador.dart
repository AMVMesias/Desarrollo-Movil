import '../modelo/capicua_modelo.dart';

/// Controlador para el ejercicio de número capicúa
class CapicuaControlador {
  final CapicuaModelo _modelo = CapicuaModelo();

  CapicuaModelo get modelo => _modelo;

  /// Verifica si el número es capicúa
  void verificar(String numero) {
    _modelo.numero = numero;
    _modelo.verificarCapicua();
  }

  /// Obtiene si es capicúa
  bool getEsCapicua() {
    return _modelo.esCapicua;
  }

  /// Obtiene el número invertido
  String getNumeroInvertido() {
    return _modelo.numeroInvertido;
  }

  /// Valida el input
  bool validarInput(String input) {
    if (input.isEmpty) return false;
    String limpio = input.replaceAll(RegExp(r'[^0-9]'), '');
    return limpio.isNotEmpty;
  }

  /// Limpia los datos
  void limpiar() {
    _modelo.limpiar();
  }
}
