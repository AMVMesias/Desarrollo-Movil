// Modelo que representa un usuario para el sistema de login
class UsuarioModelo {
  final String usuario;
  final String contrasena;
  final String tipoPerfil; // 'mesias', 'gabriel', 'brayan'

  UsuarioModelo({
    required this.usuario,
    required this.contrasena,
    required this.tipoPerfil,
  });

  // Lista de usuarios válidos (datos quemados)
  static final List<UsuarioModelo> usuariosValidos = [
    UsuarioModelo(
      usuario: 'mesias',
      contrasena: 'mesias123456',
      tipoPerfil: 'mesias',
    ),
    UsuarioModelo(
      usuario: 'gabriel',
      contrasena: 'gabriel123456',
      tipoPerfil: 'gabriel',
    ),
    UsuarioModelo(
      usuario: 'brayan',
      contrasena: 'brayan123456',
      tipoPerfil: 'brayan',
    ),
  ];

  // Valida si las credenciales son correctas
  // Retorna el tipo de perfil si es válido, vacío si no
  static String validarCredenciales(String usuario, String contrasena) {
    // Validación: no vacíos
    if (usuario.trim().isEmpty || contrasena.trim().isEmpty) {
      return '';
    }

    // Buscar usuario en la lista
    try {
      final usuarioEncontrado = usuariosValidos.firstWhere(
        (u) => u.usuario.toLowerCase() == usuario.toLowerCase().trim() 
            && u.contrasena == contrasena,
      );
      return usuarioEncontrado.tipoPerfil;
    } catch (e) {
      // No se encontró el usuario
      return '';
    }
  }
}
