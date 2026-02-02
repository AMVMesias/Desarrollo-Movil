/// Entidad que representa un grupo de contactos
class Grupo {
  final int? id;
  final String nombre;
  final String descripcion;
  final String icono;
  final int color;
  final List<int> contactoIds;

  Grupo({
    this.id,
    required this.nombre,
    this.descripcion = '',
    this.icono = 'group',
    this.color = 0xFF4CAF50, // Verde por defecto
    this.contactoIds = const [],
  });

  Grupo copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? icono,
    int? color,
    List<int>? contactoIds,
  }) {
    return Grupo(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      contactoIds: contactoIds ?? this.contactoIds,
    );
  }

  @override
  String toString() => 'Grupo(id: $id, nombre: $nombre, contactos: ${contactoIds.length})';
}
