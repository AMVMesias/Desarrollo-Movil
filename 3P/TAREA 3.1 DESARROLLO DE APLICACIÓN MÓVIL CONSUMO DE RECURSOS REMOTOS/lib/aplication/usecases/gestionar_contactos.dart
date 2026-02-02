import '../../domain/entities/contacto.dart';
import '../../domain/repositories/contacto_repository.dart';

/// Casos de uso para gestionar contactos - Capa de Aplicación
class GestionarContactos {
  final ContactoRepository repository;

  GestionarContactos(this.repository);

  /// Lista todos los contactos
  Future<List<Contacto>> listar() => repository.obtenerContactos();
  
  /// Lista solo los contactos favoritos
  Future<List<Contacto>> listarFavoritos() => repository.obtenerFavoritos();
  
  /// Agrega un nuevo contacto
  Future<void> agregar(Contacto c) => repository.agregarContacto(c);
  
  /// Actualiza un contacto existente
  Future<void> actualizar(Contacto c) => repository.actualizarContacto(c);
  
  /// Elimina un contacto
  Future<void> eliminar(int id) => repository.eliminarContacto(id);
  
  /// Cambia el estado de favorito
  Future<void> toggleFavorito(int id, bool esFavorito) => 
      repository.toggleFavorito(id, esFavorito);
}