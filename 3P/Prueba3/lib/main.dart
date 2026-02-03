import 'package:flutter/material.dart';
import 'temas/tema_general.dart';
import 'vista/paginas/pagina_inicio.dart';
import 'vista/paginas/pagina_viaje_estudios.dart';
import 'vista/paginas/pagina_capicua.dart';

void main() {
  runApp(const LeccionApp());
}

class LeccionApp extends StatelessWidget {
  const LeccionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lección 3.1 - Práctica',
      debugShowCheckedModeBanner: false,
      theme: TemaGeneral.claro,
      initialRoute: '/',
      routes: {
        '/': (context) => const PaginaInicio(),
        '/viaje-estudios': (context) => const PaginaViajeEstudios(),
        '/capicua': (context) => const PaginaCapicua(),
      },
    );
  }
}

