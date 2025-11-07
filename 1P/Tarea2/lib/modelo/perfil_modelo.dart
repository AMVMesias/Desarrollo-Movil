// Modelo simple del perfil de un usuario
class PerfilModelo {
  String nombre;
  String apellido;
  String carrera;
  String telefono;
  int edad;
  String email;
  String sobreMi;
  String githubUrl;
  List<String> habilidades;
  List<Experiencia> experiencia;
  List<Educacion> educacion;

  PerfilModelo({
    required this.nombre,
    required this.apellido,
    required this.carrera,
    required this.telefono,
    required this.edad,
    required this.email,
    required this.sobreMi,
    required this.githubUrl,
    required this.habilidades,
    required this.experiencia,
    required this.educacion,
  });

  String get nombreCompleto => '$nombre $apellido';
}

// Modelo para representar experiencia laboral/proyectos
class Experiencia {
  final String empresa;
  final String cargo;
  final String periodo;
  final String descripcion;

  Experiencia({
    required this.empresa,
    required this.cargo,
    required this.periodo,
    this.descripcion = '',
  });
}

// Modelo para representar educación
class Educacion {
  final String institucion;
  final String titulo;
  final String periodo;

  Educacion({
    required this.institucion,
    required this.titulo,
    required this.periodo,
  });
}
