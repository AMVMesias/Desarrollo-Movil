import 'package:flutter/material.dart';
import 'temas/tema_general.dart';
import 'vista/paginas/pagina_login.dart';

class PruebaTema extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Perfiles',
      theme: TemaGeneral.claro,
      debugShowCheckedModeBanner: false,
      home: const PaginaLogin(),
    );
  }
}

