import 'package:flutter/material.dart';
import 'package:sueldo_empleados/views/pagina_view.dart';
import 'package:sueldo_empleados/views/resultado_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sueldo Empleados XYZ',
      initialRoute: '/',
      routes: {
        '/': (context) => PaginaView(),
        '/resultado': (context) => ResultadoView(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}
