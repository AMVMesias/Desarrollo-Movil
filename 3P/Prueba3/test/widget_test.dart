// Pruebas principales de la aplicación Lección 3.1
// Ver archivos específicos de pruebas:
// - viaje_estudios_test.dart (pruebas unitarias Ej.3)
// - capicua_test.dart (pruebas unitarias Ej.4)
// - viaje_estudios_widget_test.dart (pruebas widget Ej.3)
// - capicua_widget_test.dart (pruebas widget Ej.4)

import 'package:flutter_test/flutter_test.dart';
import 'package:leccion3_1_practica/main.dart';

void main() {
  testWidgets('App se inicia correctamente', (tester) async {
    print('\n Prueba inicial: App se inicia');
    
    // Act
    await tester.pumpWidget(const LeccionApp());

    // Assert
    expect(find.text('Lección 3.1 - Práctica'), findsOneWidget);
    expect(find.text('Ejercicio 3'), findsOneWidget);
    expect(find.text('Ejercicio 4'), findsOneWidget);
    
    print('App iniciada correctamente ✓');
  });
}
