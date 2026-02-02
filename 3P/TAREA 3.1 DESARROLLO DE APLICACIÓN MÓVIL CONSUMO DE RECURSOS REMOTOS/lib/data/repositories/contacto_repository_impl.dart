import '../../domain/entities/contacto.dart';
import '../../domain/repositories/contacto_repository.dart';
import '../datasources/contacto_local_datasource.dart';

/// Implementación del repositorio de contactos
class ContactoRepositoryImpl implements ContactoRepository {
  final ContactoLocalDataSource local;

  ContactoRepositoryImpl(this.local);

  @override
  Future<List<Contacto>> obtenerContactos() {
    return local.obtenerContactos();
  }

  @override
  Future<List<Contacto>> obtenerFavoritos() {
    return local.obtenerFavoritos();
  }

  @override
  Future<void> agregarContacto(Contacto contacto) {
    return local.insertarContacto(contacto);
  }

  @override
  Future<void> actualizarContacto(Contacto contacto) {
    return local.actualizarContacto(contacto);
  }

  @override
  Future<void> eliminarContacto(int id) {
    return local.eliminarContacto(id);
  }

  @override
  Future<void> toggleFavorito(int id, bool esFavorito) {
    return local.toggleFavorito(id, esFavorito);
  }
}