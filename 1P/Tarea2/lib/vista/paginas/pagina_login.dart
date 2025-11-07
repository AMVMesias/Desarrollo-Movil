import 'package:flutter/material.dart';
import '../../controlador/login_controlador.dart';
import '../atomos/texto_titulo.dart';
import '../atomos/campo_texto.dart';
import '../atomos/boton_primario.dart';
import '../atomos/boton_secundario.dart';
import 'pagina_perfil.dart';

// Página de login simple
class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final LoginControlador _controlador = LoginControlador();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  
  String? _mensajeError;

  @override
  void dispose() {
    _usuarioController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  // Maneja el login
  void _handleLogin() {
    final usuario = _usuarioController.text;
    final contrasena = _contrasenaController.text;

    // Intentar login
    final tipoPerfil = _controlador.intentarLogin(usuario, contrasena);

    if (tipoPerfil.isNotEmpty) {
      // Login exitoso
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaginaPerfil(tipoPerfil: tipoPerfil),
        ),
      );
    } else {
      setState(() {
        _mensajeError = 'Usuario o contraseña incorrectos';
      });
    }
  }

  // Limpia los campos de texto
  void _limpiarCampos() {
    _usuarioController.clear();
    _contrasenaController.clear();
    setState(() {
      _mensajeError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextoTitulo('Bienvenido'),
            SizedBox(height: 30),

            // Campo de usuario
            CampoTexto(
              etiqueta: 'Usuario',
              controlador: _usuarioController,
            ),
            SizedBox(height: 20),

            // Campo de contraseña
            TextField(
              controller: _contrasenaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 20),

            // Mensaje de error
            if (_mensajeError != null) ...[
              Text(
                _mensajeError!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
            ],

            // Botón de login
            BotonPrimario(
              etiqueta: 'Ingresar',
              onPressed: _handleLogin,
            ),
            SizedBox(height: 10),

            // Botón para limpiar
            BotonSecundario(
              etiqueta: 'Limpiar',
              onPressed: _limpiarCampos,
            ),
          ],
        ),
      ),
    );
  }
}
