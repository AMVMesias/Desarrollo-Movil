import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/presentation/routes/app_routes.dart';
import 'src/domain/usescases/calcular_operario_usecases.dart';
import 'src/presentation/viewmodel/operario_viewmodel.dart';
import 'temas/tema_general.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => OperarioViewModel(CalcularAumentoUseCase()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aumento de Salario',
      debugShowCheckedModeBanner: false,
      theme: TemaGeneral.claro, // Tema que ya tenías definido
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
