import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leccion3_1_practica/main.dart';
import 'package:leccion3_1_practica/vista/paginas/pagina_viaje_estudios.dart';
import 'package:leccion3_1_practica/temas/tema_general.dart';

void main() {
  // Helper para crear widget con tema
  Widget crearWidget(Widget child) {
    return MaterialApp(
      theme: TemaGeneral.claro,
      home: child,
    );
  }

  /* Prueba Widget 1 */
  testWidgets('W1 - Render de pantalla Viaje Estudios', (tester) async {
    print('\n W1 - Render pantalla Viaje Estudios');

    // Act
    await tester.pumpWidget(crearWidget(const PaginaViajeEstudios()));

    // Assert
    expect(find.text('Ejercicio 3'), findsOneWidget);
    expect(find.text('Viaje de Estudios'), findsOneWidget);
    expect(find.text('Número de Alumnos'), findsOneWidget);
    expect(find.text('Calcular Costo'), findsOneWidget);

    print('W1 - Pantalla renderizada correctamente ✓');
  });

  /* Prueba Widget 2 */
  testWidgets('W2 - Calcular con 50 alumnos muestra resultados', (tester) async {
    print('\n W2 - Calcular con 50 alumnos');

    // Arrange
    await tester.pumpWidget(crearWidget(const PaginaViajeEstudios()));

    // Act - Ingresar número
    final campoTexto = find.byType(TextField);
    await tester.enterText(campoTexto, '50');
    await tester.pump();
    print('Ingresado: 50 alumnos');

    // Presionar calcular
    await tester.tap(find.text('Calcular Costo'));
    await tester.pump();
    print('Botón calcular presionado');

    // Assert
    expect(find.text('50'), findsWidgets);
    expect(find.text('\$70.00'), findsOneWidget);
    expect(find.text('\$3500.00'), findsOneWidget);
    expect(find.text('Limpiar'), findsOneWidget);

    print('W2 - Resultados mostrados correctamente ✓');
  });

  /* Prueba Widget 3 - Navegación */
  testWidgets('W3 - Navegación desde Home a ViajeEstudios', (tester) async {
    print('\n W3 - Navegación desde Home');

    // Arrange
    await tester.pumpWidget(const LeccionApp());

    // Act
    final botonEjercicio3 = find.text('Ejercicio 3');
    expect(botonEjercicio3, findsOneWidget);
    
    await tester.tap(botonEjercicio3);
    await tester.pumpAndSettle();
    print('Navegado a Ejercicio 3');

    // Assert
    expect(find.text('Viaje de Estudios'), findsOneWidget);

    print('W3 - Navegación correcta ✓');
  });
}
