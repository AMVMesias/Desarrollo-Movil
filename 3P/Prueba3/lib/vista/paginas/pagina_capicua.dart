import 'package:flutter/material.dart';
import '../../controlador/capicua_controlador.dart';
import '../../temas/esquema_color.dart';
import '../atomos/boton_primario.dart';
import '../atomos/boton_secundario.dart';
import '../atomos/campo_numerico.dart';
import '../atomos/texto_titulo.dart';
import '../moleculas/tarjeta_resultado.dart';
import '../moleculas/tarjeta_info.dart';

/// Página del Ejercicio 4: Número Capicúa
class PaginaCapicua extends StatefulWidget {
  const PaginaCapicua({Key? key}) : super(key: key);

  @override
  State<PaginaCapicua> createState() => _PaginaCapicuaState();
}

class _PaginaCapicuaState extends State<PaginaCapicua> {
  final TextEditingController _numeroController = TextEditingController();
  final CapicuaControlador _controlador = CapicuaControlador();
  bool _mostrarResultado = false;

  void _verificar() {
    if (!_controlador.validarInput(_numeroController.text)) {
      _mostrarError('Por favor ingrese un número válido');
      return;
    }

    setState(() {
      _controlador.verificar(_numeroController.text);
      _mostrarResultado = true;
    });
  }

  void _limpiar() {
    setState(() {
      _numeroController.clear();
      _controlador.limpiar();
      _mostrarResultado = false;
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
    _numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 4'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Información
              const TarjetaInfo(
                mensaje: 'Un número capicúa (palíndromo) se lee igual de '
                    'izquierda a derecha que de derecha a izquierda.\n\n'
                    'Ejemplos: 121, 12321, 1001, 55',
                icono: Icons.lightbulb_outline,
              ),
              const SizedBox(height: 24),

              // Formulario
              const TextoTitulo('Número Capicúa'),
              const SizedBox(height: 8),
              const TextoSubtitulo('Ingrese un número para verificar'),
              const SizedBox(height: 24),

              CampoNumerico(
                etiqueta: 'Número a verificar',
                controlador: _numeroController,
                pista: 'Ej: 12321',
                icono: Icons.pin,
              ),
              const SizedBox(height: 20),

              BotonPrimario(
                etiqueta: 'Verificar',
                onPressed: _verificar,
                icono: Icons.check_circle,
              ),
              const SizedBox(height: 12),

              if (_mostrarResultado)
                BotonSecundario(
                  etiqueta: 'Limpiar',
                  onPressed: _limpiar,
                  icono: Icons.refresh,
                ),

              // Resultado
              if (_mostrarResultado) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                _construirResultadoWidget(),

                const SizedBox(height: 16),
                TarjetaResultado(
                  titulo: 'Número Original',
                  valor: _numeroController.text,
                  icono: Icons.format_list_numbered,
                ),
                const SizedBox(height: 12),
                TarjetaResultado(
                  titulo: 'Número Invertido',
                  valor: _controlador.getNumeroInvertido(),
                  icono: Icons.swap_horiz,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirResultadoWidget() {
    final esCapicua = _controlador.getEsCapicua();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: esCapicua
              ? [ColorApp.secundario, ColorApp.primario]
              : [Colors.orange[300]!, Colors.orange[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (esCapicua ? ColorApp.primario : Colors.orange).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            esCapicua ? Icons.check_circle : Icons.cancel,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Text(
            esCapicua ? '¡ES CAPICÚA!' : 'NO ES CAPICÚA',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            esCapicua
                ? 'El número se lee igual en ambos sentidos'
                : 'El número NO se lee igual en ambos sentidos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
