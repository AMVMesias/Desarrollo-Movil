import 'package:drift/drift.dart';
import '../database/database.dart';
import '../../domain/entities/contacto.dart' as domain;

/// Data Source local para contactos usando Drift ORM
class ContactoLocalDataSource {
  final AppDatabase db;
  
  ContactoLocalDataSource(this.db);

  /// Obtiene todos los contactos ordenados por nombre
  Future<List<domain.Contacto>> obtenerContactos() async {
    final result = await db.obtenerContactos();
    return result.map(_mapToDomain).toList();
  }

  /// Obtiene solo los contactos favoritos
  Future<List<domain.Contacto>> obtenerFavoritos() async {
    final result = await db.obtenerFavoritos();
    return result.map(_mapToDomain).toList();
  }

  /// Inserta un nuevo contacto
  Future<void> insertarContacto(domain.Contacto c) async {
    await db.insertarContacto(ContactosCompanion.insert(
      nombre: c.nombre,
      descripcion: Value(c.descripcion),
      telefono: Value(c.telefono),
      email: Value(c.email),
      foto: Value(c.foto),
      esFavorito: Value(c.esFavorito),
    ));
  }

  /// Actualiza un contacto existente
  Future<void> actualizarContacto(domain.Contacto c) async {
    await db.actualizarContacto(Contacto(
      id: c.id!,
      nombre: c.nombre,
      descripcion: c.descripcion,
      telefono: c.telefono,
      email: c.email,
      foto: c.foto,
      esFavorito: c.esFavorito,
    ));
  }

  /// Elimina un contacto por su ID
  Future<void> eliminarContacto(int id) async {
    await db.eliminarContacto(id);
  }

  /// Cambia el estado de favorito
  Future<void> toggleFavorito(int id, bool esFavorito) async {
    await db.toggleFavorito(id, esFavorito);
  }

  /// Mapea de entidad Drift a entidad de dominio
  domain.Contacto _mapToDomain(Contacto c) {
    return domain.Contacto(
      id: c.id,
      nombre: c.nombre,
      descripcion: c.descripcion,
      telefono: c.telefono,
      email: c.email,
      foto: c.foto,
      esFavorito: c.esFavorito,
    );
  }
}