import 'package:flutter/material.dart';
import '../../controlador/viaje_estudios_controlador.dart';
import '../../temas/esquema_color.dart';
import '../atomos/boton_primario.dart';
import '../atomos/boton_secundario.dart';
import '../atomos/campo_numerico.dart';
import '../atomos/texto_titulo.dart';
import '../moleculas/tarjeta_resultado.dart';
import '../moleculas/tarjeta_info.dart';

/// Página del Ejercicio 3: Viaje de Estudios
class PaginaViajeEstudios extends StatefulWidget {
  const PaginaViajeEstudios({Key? key}) : super(key: key);

  @override
  State<PaginaViajeEstudios> createState() => _PaginaViajeEstudiosState();
}

class _PaginaViajeEstudiosState extends State<PaginaViajeEstudios> {
  final TextEditingController _alumnosController = TextEditingController();
  final ViajeEstudiosControlador _controlador = ViajeEstudiosControlador();
  bool _mostrarResultados = false;

  void _calcular() {
    if (!_controlador.validarInput(_alumnosController.text)) {
      _mostrarError('Por favor ingrese un número válido de alumnos');
      return;
    }

    setState(() {
      _controlador.calcular(_alumnosController.text);
      _mostrarResultados = true;
    });
  }

  void _limpiar() {
    setState(() {
      _alumnosController.clear();
      _controlador.limpiar();
      _mostrarResultados = false;
    });
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: ColorApp.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _alumnosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 3'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Información
              const TarjetaInfo(
                mensaje: 'El costo varía según la cantidad de alumnos:\n'
                    '• 100+ alumnos: \$65.00 c/u\n'
                    '• 50-99 alumnos: \$70.00 c/u\n'
                    '• 30-49 alumnos: \$95.00 c/u\n'
                    '• Menos de 30: \$4000.00 fijo',
              ),
              const SizedBox(height: 24),

              // Formulario
              const TextoTitulo('Viaje de Estudios'),
              const SizedBox(height: 8),
              const TextoSubtitulo('Ingrese el número de alumnos'),
              const SizedBox(height: 24),

              CampoNumerico(
                etiqueta: 'Número de Alumnos',
                controlador: _alumnosController,
                pista: 'Ej: 50',
                icono: Icons.people,
              ),
              const SizedBox(height: 20),

              BotonPrimario(
                etiqueta: 'Calcular Costo',
                onPressed: _calcular,
                icono: Icons.calculate,
              ),
              const SizedBox(height: 12),

              if (_mostrarResultados)
                BotonSecundario(
                  etiqueta: 'Limpiar',
                  onPressed: _limpiar,
                  icono: Icons.refresh,
                ),

              // Resultados
              if (_mostrarResultados) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                TarjetaInfo(
                  mensaje: _controlador.getMensajeRango(),
                  icono: Icons.category,
                  colorFondo: ColorApp.acento.withOpacity(0.2),
                ),
                const SizedBox(height: 16),

                TarjetaResultado(
                  titulo: 'Número de Alumnos',
                  valor: '${_controlador.getNumeroAlumnos()}',
                  icono: Icons.people,
                ),
                const SizedBox(height: 12),
                TarjetaResultado(
                  titulo: 'Costo por Alumno',
                  valor: _controlador.getCostoPorAlumno(),
                  icono: Icons.person,
                ),
                const SizedBox(height: 12),
                TarjetaResultado(
                  titulo: 'Costo Total a Pagar',
                  valor: _controlador.getCostoTotal(),
                  icono: Icons.attach_money,
                  colorFondo: ColorApp.superficie.withOpacity(0.3),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
