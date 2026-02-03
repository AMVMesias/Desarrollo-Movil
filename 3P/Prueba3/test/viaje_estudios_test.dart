import 'package:flutter_test/flutter_test.dart';
import '../lib/modelo/viaje_estudios_modelo.dart';
import '../lib/controlador/viaje_estudios_controlador.dart';

void main() {
  print('Pruebas Unitarias - Ejercicio 3: Viaje de Estudios');
  print('==================================================');

  group('Grupo 1 - Pruebas del Modelo ViajeEstudiosModelo', () {
    // Instancia del modelo
    late ViajeEstudiosModelo modelo;

    setUp(() {
      modelo = ViajeEstudiosModelo();
    });

    // CASO DE PRUEBA 1: 100 o más alumnos
    test('Prueba 1 - 100 alumnos cobra \$65.00 por alumno', () {
      print('\n Prueba 1: 100 alumnos a \$65.00 c/u');
      
      // Arrange - preparar datos
      modelo.numeroAlumnos = 100;
      print('Datos de entrada --> alumnos: 100');

      // Act - ejecutar
      modelo.calcularCostos();
      print('Resultado --> costoPorAlumno: ${modelo.costoPorAlumno}, total: ${modelo.costoTotal}');

      // Assert - comprobar
      expect(modelo.costoPorAlumno, 65.0, reason: 'Costo debe ser \$65.00');
      expect(modelo.costoTotal, 6500.0, reason: 'Total debe ser 100 * 65 = 6500');
      print('Prueba 1 pasada ✓');
    });

    // CASO DE PRUEBA 2: 50-99 alumnos
    test('Prueba 2 - 75 alumnos cobra \$70.00 por alumno', () {
      print('\n Prueba 2: 75 alumnos a \$70.00 c/u');
      
      // Arrange
      modelo.numeroAlumnos = 75;
      print('Datos de entrada --> alumnos: 75');

      // Act
      modelo.calcularCostos();
      print('Resultado --> costoPorAlumno: ${modelo.costoPorAlumno}, total: ${modelo.costoTotal}');

      // Assert
      expect(modelo.costoPorAlumno, 70.0, reason: 'Costo debe ser \$70.00');
      expect(modelo.costoTotal, 5250.0, reason: 'Total debe ser 75 * 70 = 5250');
      print('Prueba 2 pasada ✓');
    });

    // CASO DE PRUEBA 3: 30-49 alumnos
    test('Prueba 3 - 40 alumnos cobra \$95.00 por alumno', () {
      print('\n Prueba 3: 40 alumnos a \$95.00 c/u');
      
      // Arrange
      modelo.numeroAlumnos = 40;
      print('Datos de entrada --> alumnos: 40');

      // Act
      modelo.calcularCostos();
      print('Resultado --> costoPorAlumno: ${modelo.costoPorAlumno}, total: ${modelo.costoTotal}');

      // Assert
      expect(modelo.costoPorAlumno, 95.0, reason: 'Costo debe ser \$95.00');
      expect(modelo.costoTotal, 3800.0, reason: 'Total debe ser 40 * 95 = 3800');
      print('Prueba 3 pasada ✓');
    });

    // CASO DE PRUEBA 4: Menos de 30 alumnos (costo fijo)
    test('Prueba 4 - 20 alumnos tiene costo fijo \$4000.00', () {
      print('\n Prueba 4: 20 alumnos con renta fija \$4000.00');
      
      // Arrange
      modelo.numeroAlumnos = 20;
      print('Datos de entrada --> alumnos: 20');

      // Act
      modelo.calcularCostos();
      print('Resultado --> costoPorAlumno: ${modelo.costoPorAlumno}, total: ${modelo.costoTotal}');

      // Assert
      expect(modelo.costoTotal, 4000.0, reason: 'Total debe ser \$4000.00 fijo');
      expect(modelo.costoPorAlumno, 200.0, reason: 'Costo/alumno = 4000/20 = 200');
      print('Prueba 4 pasada ✓');
    });
  });

  group('Grupo 2 - Pruebas del Controlador ViajeEstudiosControlador', () {
    late ViajeEstudiosControlador controlador;

    setUp(() {
      controlador = ViajeEstudiosControlador();
    });

    test('Prueba 5 - validarInput retorna false para entrada vacía', () {
      print('\n Prueba 5: Validar entrada vacía');
      
      // Arrange
      const entrada = '';
      print('Datos de entrada --> "$entrada"');

      // Act
      final resultado = controlador.validarInput(entrada);
      print('Resultado --> $resultado');

      // Assert
      expect(resultado, false, reason: 'Debe retornar false para vacío');
      print('Prueba 5 pasada ✓');
    });

    test('Prueba 6 - calcular actualiza correctamente el modelo', () {
      print('\n Prueba 6: Calcular con 50 alumnos');
      
      // Arrange
      const entrada = '50';
      print('Datos de entrada --> "$entrada"');

      // Act
      controlador.calcular(entrada);
      print('Resultado --> alumnos: ${controlador.getNumeroAlumnos()}, costo: ${controlador.getCostoPorAlumno()}, total: ${controlador.getCostoTotal()}');

      // Assert
      expect(controlador.getNumeroAlumnos(), 50);
      expect(controlador.getCostoPorAlumno(), '\$70.00');
      expect(controlador.getCostoTotal(), '\$3500.00');
      print('Prueba 6 pasada ✓');
    });
  });
}

