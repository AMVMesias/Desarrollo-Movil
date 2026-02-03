/// Modelo para el cálculo del viaje de estudios
class ViajeEstudiosModelo {
  int _numeroAlumnos;
  double _costoPorAlumno;
  double _costoTotal;

  ViajeEstudiosModelo({
    int numeroAlumnos = 0,
    double costoPorAlumno = 0.0,
    double costoTotal = 0.0,
  })  : _numeroAlumnos = numeroAlumnos,
        _costoPorAlumno = costoPorAlumno,
        _costoTotal = costoTotal;

  // Getters
  int get numeroAlumnos => _numeroAlumnos;
  double get costoPorAlumno => _costoPorAlumno;
  double get costoTotal => _costoTotal;

  // Setters
  set numeroAlumnos(int value) => _numeroAlumnos = value;
  set costoPorAlumno(double value) => _costoPorAlumno = value;
  set costoTotal(double value) => _costoTotal = value;

  /// Calcula el costo según las reglas:
  /// - 100+ alumnos: $65.00 c/u
  /// - 50-99 alumnos: $70.00 c/u
  /// - 30-49 alumnos: $95.00 c/u
  /// - <30 alumnos: $4000.00 fijo
  void calcularCostos() {
    if (_numeroAlumnos <= 0) {
      _costoPorAlumno = 0;
      _costoTotal = 0;
      return;
    }

    // Usar ciclo para determinar rango
    List<Map<String, dynamic>> rangos = [
      {'min': 100, 'max': double.infinity, 'costo': 65.0, 'esFijo': false},
      {'min': 50, 'max': 99, 'costo': 70.0, 'esFijo': false},
      {'min': 30, 'max': 49, 'costo': 95.0, 'esFijo': false},
      {'min': 1, 'max': 29, 'costo': 4000.0, 'esFijo': true},
    ];

    for (var rango in rangos) {
      if (_numeroAlumnos >= rango['min'] && _numeroAlumnos <= rango['max']) {
        if (rango['esFijo']) {
          _costoTotal = rango['costo'];
          _costoPorAlumno = _costoTotal / _numeroAlumnos;
        } else {
          _costoPorAlumno = rango['costo'];
          _costoTotal = _costoPorAlumno * _numeroAlumnos;
        }
        break;
      }
    }
  }

  /// Obtiene el mensaje del rango aplicado
  String obtenerMensajeRango() {
    if (_numeroAlumnos >= 100) {
      return '100 o más alumnos: \$65.00 por alumno';
    } else if (_numeroAlumnos >= 50) {
      return '50 a 99 alumnos: \$70.00 por alumno';
    } else if (_numeroAlumnos >= 30) {
      return '30 a 49 alumnos: \$95.00 por alumno';
    } else if (_numeroAlumnos > 0) {
      return 'Menos de 30 alumnos: Renta fija \$4000.00';
    }
    return '';
  }

  /// Reinicia los valores
  void limpiar() {
    _numeroAlumnos = 0;
    _costoPorAlumno = 0;
    _costoTotal = 0;
  }
}
