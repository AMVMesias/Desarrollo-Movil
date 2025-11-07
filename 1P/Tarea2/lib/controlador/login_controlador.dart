import '../modelo/usuario_modelo.dart';

// Controlador que gestiona la lógica del login
class LoginControlador {
  // Intenta hacer login con las credenciales proporcionadas
  // Retorna el tipo de perfil si es exitoso, vacío si falla
  String intentarLogin(String usuario, String contrasena) {
    // Validar que no estén vacíos
    if (usuario.trim().isEmpty || contrasena.trim().isEmpty) {
      return '';
    }

    // Intentar autenticar con el modelo
    return UsuarioModelo.validarCredenciales(usuario, contrasena);
  }
}
