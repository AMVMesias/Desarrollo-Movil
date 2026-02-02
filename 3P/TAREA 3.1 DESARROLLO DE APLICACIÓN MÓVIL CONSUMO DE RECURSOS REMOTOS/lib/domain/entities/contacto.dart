/// Entidad Contacto - Capa de Dominio
class Contacto {
  final int? id;
  final String nombre;
  final String descripcion;
  final String telefono;
  final String email;
  final String foto;
  final bool esFavorito;

  Contacto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.telefono,
    this.email = '',
    required this.foto,
    this.esFavorito = false,
  });

  /// Crea una copia del contacto con los campos modificados
  Contacto copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? telefono,
    String? email,
    String? foto,
    bool? esFavorito,
  }) {
    return Contacto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      foto: foto ?? this.foto,
      esFavorito: esFavorito ?? this.esFavorito,
    );
  }
}