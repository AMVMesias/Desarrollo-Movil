import '../modelo/viaje_estudios_modelo.dart';

/// Controlador para el ejercicio del viaje de estudios
class ViajeEstudiosControlador {
  final ViajeEstudiosModelo _modelo = ViajeEstudiosModelo();

  ViajeEstudiosModelo get modelo => _modelo;

  /// Establece el número de alumnos y calcula
  void calcular(String numeroAlumnosStr) {
    int numeroAlumnos = int.tryParse(numeroAlumnosStr) ?? 0;
    _modelo.numeroAlumnos = numeroAlumnos;
    _modelo.calcularCostos();
  }

  /// Obtiene el costo por alumno formateado
  String getCostoPorAlumno() {
    return '\$${_modelo.costoPorAlumno.toStringAsFixed(2)}';
  }

  /// Obtiene el costo total formateado
  String getCostoTotal() {
    return '\$${_modelo.costoTotal.toStringAsFixed(2)}';
  }

  /// Obtiene el número de alumnos
  int getNumeroAlumnos() {
    return _modelo.numeroAlumnos;
  }

  /// Obtiene el mensaje del rango
  String getMensajeRango() {
    return _modelo.obtenerMensajeRango();
  }

  /// Valida el input
  bool validarInput(String input) {
    if (input.isEmpty) return false;
    int? numero = int.tryParse(input);
    return numero != null && numero > 0;
  }

  /// Limpia los datos
  void limpiar() {
    _modelo.limpiar();
  }
}
