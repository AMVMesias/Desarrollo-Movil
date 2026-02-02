import '../entities/contacto.dart';

/// Interfaz del repositorio de contactos - Capa de Dominio
abstract class ContactoRepository {
  /// Obtiene todos los contactos
  Future<List<Contacto>> obtenerContactos();
  
  /// Obtiene solo los contactos marcados como favoritos
  Future<List<Contacto>> obtenerFavoritos();
  
  /// Agrega un nuevo contacto
  Future<void> agregarContacto(Contacto contacto);
  
  /// Actualiza un contacto existente
  Future<void> actualizarContacto(Contacto contacto);
  
  /// Elimina un contacto por su ID
  Future<void> eliminarContacto(int id);
  
  /// Cambia el estado de favorito de un contacto
  Future<void> toggleFavorito(int id, bool esFavorito);
}
