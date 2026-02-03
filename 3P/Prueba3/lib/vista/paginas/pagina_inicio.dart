import 'package:flutter/material.dart';
import '../../temas/esquema_color.dart';
import '../moleculas/item_menu.dart';

/// Página principal con menú de ejercicios
class PaginaInicio extends StatelessWidget {
  const PaginaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lección 3.1 - Práctica'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorApp.primario, ColorApp.secundario],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.school, size: 60, color: Colors.white),
                    const SizedBox(height: 12),
                    const Text(
                      'Grupo 2 - Ejercicios',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selecciona un ejercicio para comenzar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menú de ejercicios
              Expanded(
                child: ListView(
                  children: [
                    ItemMenu(
                      titulo: 'Ejercicio 3',
                      subtitulo: 'Viaje de Estudios - Cálculo de costos',
                      icono: Icons.directions_bus,
                      onTap: () {
                        Navigator.pushNamed(context, '/viaje-estudios');
                      },
                    ),
                    const SizedBox(height: 16),
                    ItemMenu(
                      titulo: 'Ejercicio 4',
                      subtitulo: 'Verificar Número Capicúa',
                      icono: Icons.swap_horiz,
                      onTap: () {
                        Navigator.pushNamed(context, '/capicua');
                      },
                    ),
                  ],
                ),
              ),

              // Footer
              Text(
                'Desarrollado con Flutter 💚',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
