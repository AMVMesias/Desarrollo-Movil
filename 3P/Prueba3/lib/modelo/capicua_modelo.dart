/// Modelo para verificar si un número es capicúa
class CapicuaModelo {
  String _numero;
  bool _esCapicua;
  String _numeroInvertido;

  CapicuaModelo({
    String numero = '',
    bool esCapicua = false,
    String numeroInvertido = '',
  })  : _numero = numero,
        _esCapicua = esCapicua,
        _numeroInvertido = numeroInvertido;

  // Getters
  String get numero => _numero;
  bool get esCapicua => _esCapicua;
  String get numeroInvertido => _numeroInvertido;

  // Setters
  set numero(String value) => _numero = value;
  set esCapicua(bool value) => _esCapicua = value;
  set numeroInvertido(String value) => _numeroInvertido = value;

  /// Verifica si el número es capicúa usando ciclo for
  void verificarCapicua() {
    if (_numero.isEmpty) {
      _esCapicua = false;
      _numeroInvertido = '';
      return;
    }

    // Limpiar el número
    String numeroLimpio = _numero.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numeroLimpio.isEmpty) {
      _esCapicua = false;
      _numeroInvertido = '';
      return;
    }

    // Invertir usando ciclo for
    StringBuffer invertido = StringBuffer();
    for (int i = numeroLimpio.length - 1; i >= 0; i--) {
      invertido.write(numeroLimpio[i]);
    }
    
    _numeroInvertido = invertido.toString();
    _esCapicua = numeroLimpio == _numeroInvertido;
  }

  /// Método alternativo usando ciclo while
  bool verificarCapicuaConWhile(String num) {
    String numeroLimpio = num.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numeroLimpio.isEmpty) return false;

    int inicio = 0;
    int fin = numeroLimpio.length - 1;
    bool resultado = true;

    while (inicio < fin && resultado) {
      if (numeroLimpio[inicio] != numeroLimpio[fin]) {
        resultado = false;
      }
      inicio++;
      fin--;
    }

    return resultado;
  }

  /// Reinicia los valores
  void limpiar() {
    _numero = '';
    _esCapicua = false;
    _numeroInvertido = '';
  }
}
