// ============================================================================
// CONTROLLER - LÓGICA DE NEGOCIO (MVC)
// ============================================================================
// Contiene toda la lógica de cálculo de pólizas
// NO conoce la UI, NO conoce el backend
// Solo se encarga de los cálculos según las reglas del negocio
// ============================================================================

class PolizaController {
  /// Calcula el costo total de la póliza
  /// Fórmula: Cargo por valor + Cargo por modelo + Cargo por edad + Cargo por accidentes
  double calcularCostoPoliza({
    required double valorAuto,
    required String modelo,
    required int edad,
    required int accidentes,
  }) {
    final cargoPorValor = _calcularCargoPorValor(valorAuto);
    final cargoPorModelo = _calcularCargoPorModelo(valorAuto, modelo);
    final cargoPorEdad = _calcularCargoPorEdad(edad);
    final cargoPorAccidentes = _calcularCargoPorAccidentes(accidentes);

    return cargoPorValor + cargoPorModelo + cargoPorEdad + cargoPorAccidentes;
  }

  /// Cargo por valor: 3.5% del valor del automóvil
  double _calcularCargoPorValor(double valorAuto) {
    return valorAuto * 0.035;
  }

  /// Cargo por modelo según el tipo:
  /// - Modelo A: 1.1% del valor del auto
  /// - Modelo B: 1.2% del valor del auto  
  /// - Modelo C: 1.5% del valor del auto
  double _calcularCargoPorModelo(double valorAuto, String modelo) {
    switch (modelo.toUpperCase()) {
      case 'A':
        return valorAuto * 0.011;
      case 'B':
        return valorAuto * 0.012;
      case 'C':
        return valorAuto * 0.015;
      default:
        return 0.0;
    }
  }

  /// Cargo por edad del propietario:
  /// - >=18 y <24 años: $360
  /// - >=24 y <53 años: $240
  /// - >=53 o más años: $430
  double _calcularCargoPorEdad(int edad) {
    if (edad >= 18 && edad < 24) {
      return 360.0;
    } else if (edad >= 24 && edad < 53) {
      return 240.0;
    } else if (edad >= 53) {
      return 430.0;
    }
    return 0.0;
  }

  /// Cargo por accidentes previos:
  /// - $17 por los primeros tres accidentes
  /// - $21 por cada accidente extra
  double _calcularCargoPorAccidentes(int accidentes) {
    if (accidentes <= 0) return 0.0;
    
    if (accidentes <= 3) {
      return accidentes * 17.0;
    } else {
      // Primeros 3 accidentes: 3 * $17 = $51
      // Accidentes extras: (total - 3) * $21
      return (3 * 17.0) + ((accidentes - 3) * 21.0);
    }
  }

  /// Valida que la edad esté en el rango permitido
  /// La compañía no asegura automóviles a personas con edad fuera de estos rangos
  bool validarEdad(int edad) {
    return edad >= 18 && edad <= 100;
  }

  /// Obtiene el texto descriptivo del cargo por edad
  String obtenerRangoEdad(int edad) {
    if (edad >= 18 && edad < 24) {
      return '>=18 y <24 años';
    } else if (edad >= 24 && edad < 53) {
      return '>=24 y <53 años';
    } else if (edad >= 53) {
      return '>=53 o más años';
    }
    return 'Edad no válida';
  }

  /// Obtiene el porcentaje del modelo
  double obtenerPorcentajeModelo(String modelo) {
    switch (modelo.toUpperCase()) {
      case 'A':
        return 1.1;
      case 'B':
        return 1.2;
      case 'C':
        return 1.5;
      default:
        return 0.0;
    }
  }
}
