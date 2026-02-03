import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leccion3_1_practica/main.dart';
import 'package:leccion3_1_practica/vista/paginas/pagina_capicua.dart';
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
  testWidgets('W1 - Render de pantalla Capicúa', (tester) async {
    print('\n W1 - Render pantalla Capicúa');

    // Act
    await tester.pumpWidget(crearWidget(const PaginaCapicua()));

    // Assert
    expect(find.text('Ejercicio 4'), findsOneWidget);
    expect(find.text('Número Capicúa'), findsOneWidget);
    expect(find.text('Número a verificar'), findsOneWidget);
    expect(find.text('Verificar'), findsOneWidget);

    print('W1 - Pantalla renderizada correctamente ✓');
  });

  /* Prueba Widget 2 */
  testWidgets('W2 - Verificar 12321 muestra ES CAPICÚA', (tester) async {
    print('\n W2 - Verificar número capicúa');

    // Arrange
    await tester.pumpWidget(crearWidget(const PaginaCapicua()));

    // Act - Ingresar número
    final campoTexto = find.byType(TextField);
    await tester.enterText(campoTexto, '12321');
    await tester.pump();
    print('Ingresado: 12321');

    // Presionar verificar
    await tester.tap(find.text('Verificar'));
    await tester.pump();
    print('Botón verificar presionado');

    // Assert
    expect(find.text('¡ES CAPICÚA!'), findsOneWidget);
    expect(find.text('12321'), findsWidgets);
    expect(find.text('Limpiar'), findsOneWidget);

    print('W2 - Resultado capicúa mostrado correctamente ✓');
  });

  /* Prueba Widget 3 */
  testWidgets('W3 - Verificar 12345 muestra NO ES CAPICÚA', (tester) async {
    print('\n W3 - Verificar número NO capicúa');

    // Arrange
    await tester.pumpWidget(crearWidget(const PaginaCapicua()));

    // Act
    final campoTexto = find.byType(TextField);
    await tester.enterText(campoTexto, '12345');
    await tester.pump();
    print('Ingresado: 12345');

    await tester.tap(find.text('Verificar'));
    await tester.pump();
    print('Botón verificar presionado');

    // Assert
    expect(find.text('NO ES CAPICÚA'), findsOneWidget);
    expect(find.text('54321'), findsOneWidget);

    print('W3 - Resultado NO capicúa mostrado correctamente ✓');
  });

  /* Prueba Widget 4 - Navegación */
  testWidgets('W4 - Navegación desde Home a Capicúa', (tester) async {
    print('\n W4 - Navegación desde Home');

    // Arrange
    await tester.pumpWidget(const LeccionApp());

    // Act
    final botonEjercicio4 = find.text('Ejercicio 4');
    expect(botonEjercicio4, findsOneWidget);
    
    await tester.tap(botonEjercicio4);
    await tester.pumpAndSettle();
    print('Navegado a Ejercicio 4');

    // Assert
    expect(find.text('Número Capicúa'), findsOneWidget);

    print('W4 - Navegación correcta ✓');
  });
}
