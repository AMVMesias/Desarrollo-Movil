import 'package:flutter_test/flutter_test.dart';
import '../lib/modelo/capicua_modelo.dart';
import '../lib/controlador/capicua_controlador.dart';

void main() {
  print('Pruebas Unitarias - Ejercicio 4: Número Capicúa');
  print('===============================================');

  group('Grupo 1 - Pruebas del Modelo CapicuaModelo', () {
    late CapicuaModelo modelo;

    setUp(() {
      modelo = CapicuaModelo();
    });

    // CASO DE PRUEBA 1: Número capicúa de 3 dígitos
    test('Prueba 1 - 121 ES un número capicúa', () {
      print('\n Prueba 1: Verificar que 121 es capicúa');
      
      // Arrange
      modelo.numero = '121';
      print('Datos de entrada --> número: 121');

      // Act
      modelo.verificarCapicua();
      print('Resultado --> esCapicua: ${modelo.esCapicua}, invertido: ${modelo.numeroInvertido}');

      // Assert
      expect(modelo.esCapicua, true, reason: '121 debe ser capicúa');
      expect(modelo.numeroInvertido, '121', reason: 'Invertido debe ser 121');
      print('Prueba 1 pasada ✓');
    });

    // CASO DE PRUEBA 2: Número capicúa de 5 dígitos
    test('Prueba 2 - 12321 ES un número capicúa', () {
      print('\n Prueba 2: Verificar que 12321 es capicúa');
      
      // Arrange
      modelo.numero = '12321';
      print('Datos de entrada --> número: 12321');

      // Act
      modelo.verificarCapicua();
      print('Resultado --> esCapicua: ${modelo.esCapicua}, invertido: ${modelo.numeroInvertido}');

      // Assert
      expect(modelo.esCapicua, true, reason: '12321 debe ser capicúa');
      expect(modelo.numeroInvertido, '12321', reason: 'Invertido debe ser 12321');
      print('Prueba 2 pasada ✓');
    });

    // CASO DE PRUEBA 3: Número NO capicúa
    test('Prueba 3 - 123 NO es un número capicúa', () {
      print('\n Prueba 3: Verificar que 123 NO es capicúa');
      
      // Arrange
      modelo.numero = '123';
      print('Datos de entrada --> número: 123');

      // Act
      modelo.verificarCapicua();
      print('Resultado --> esCapicua: ${modelo.esCapicua}, invertido: ${modelo.numeroInvertido}');

      // Assert
      expect(modelo.esCapicua, false, reason: '123 NO debe ser capicúa');
      expect(modelo.numeroInvertido, '321', reason: 'Invertido debe ser 321');
      print('Prueba 3 pasada ✓');
    });

    // CASO DE PRUEBA 4: Número NO capicúa largo
    test('Prueba 4 - 12345 NO es un número capicúa', () {
      print('\n Prueba 4: Verificar que 12345 NO es capicúa');
      
      // Arrange
      modelo.numero = '12345';
      print('Datos de entrada --> número: 12345');

      // Act
      modelo.verificarCapicua();
      print('Resultado --> esCapicua: ${modelo.esCapicua}, invertido: ${modelo.numeroInvertido}');

      // Assert
      expect(modelo.esCapicua, false, reason: '12345 NO debe ser capicúa');
      expect(modelo.numeroInvertido, '54321', reason: 'Invertido debe ser 54321');
      print('Prueba 4 pasada ✓');
    });

    // Prueba con while
    test('Prueba 5 - verificarCapicuaConWhile funciona correctamente', () {
      print('\n Prueba 5: Método alternativo con while');
      
      // Arrange & Act & Assert
      print('Probando 12321...');
      expect(modelo.verificarCapicuaConWhile('12321'), true);
      print('12321 es capicúa ✓');

      print('Probando 12345...');
      expect(modelo.verificarCapicuaConWhile('12345'), false);
      print('12345 no es capicúa ✓');

      print('Prueba 5 pasada ✓');
    });
  });

  group('Grupo 2 - Pruebas del Controlador CapicuaControlador', () {
    late CapicuaControlador controlador;

    setUp(() {
      controlador = CapicuaControlador();
    });

    test('Prueba 6 - validarInput retorna false para entrada vacía', () {
      print('\n Prueba 6: Validar entrada vacía');
      
      // Arrange
      const entrada = '';
      print('Datos de entrada --> "$entrada"');

      // Act
      final resultado = controlador.validarInput(entrada);
      print('Resultado --> $resultado');

      // Assert
      expect(resultado, false, reason: 'Debe retornar false para vacío');
      print('Prueba 6 pasada ✓');
    });

    test('Prueba 7 - verificar determina correctamente capicúa', () {
      print('\n Prueba 7: Verificar número capicúa');
      
      // Arrange
      const entrada = '12321';
      print('Datos de entrada --> "$entrada"');

      // Act
      controlador.verificar(entrada);
      print('Resultado --> esCapicua: ${controlador.getEsCapicua()}, invertido: ${controlador.getNumeroInvertido()}');

      // Assert
      expect(controlador.getEsCapicua(), true);
      expect(controlador.getNumeroInvertido(), '12321');
      print('Prueba 7 pasada ✓');
    });

    test('Prueba 8 - verificar determina correctamente NO capicúa', () {
      print('\n Prueba 8: Verificar número NO capicúa');
      
      // Arrange
      const entrada = '12345';
      print('Datos de entrada --> "$entrada"');

      // Act
      controlador.verificar(entrada);
      print('Resultado --> esCapicua: ${controlador.getEsCapicua()}, invertido: ${controlador.getNumeroInvertido()}');

      // Assert
      expect(controlador.getEsCapicua(), false);
      expect(controlador.getNumeroInvertido(), '54321');
      print('Prueba 8 pasada ✓');
    });
  });
}
