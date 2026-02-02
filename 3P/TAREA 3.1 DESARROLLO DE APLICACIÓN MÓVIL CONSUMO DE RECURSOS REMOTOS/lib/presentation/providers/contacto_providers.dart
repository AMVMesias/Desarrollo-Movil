import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../domain/entities/contacto.dart';
import '../../data/datasources/contacto_local_datasource.dart';
import '../../data/repositories/contacto_repository_impl.dart';
import '../../data/database/database.dart' show GruposCompanion;
import '../../aplication/usecases/gestionar_contactos.dart';
import '../../core/database/drift_service.dart';

/// Provider para manejar el estado de los contactos
final contactoProvider = StateNotifierProvider<ContactoNotifier, AsyncValue<List<Contacto>>>(
  (ref) => ContactoNotifier(),
);

/// Provider para manejar los contactos favoritos
final favoritosProvider = StateNotifierProvider<FavoritosNotifier, AsyncValue<List<Contacto>>>(
  (ref) => FavoritosNotifier(),
);

/// Notifier para la lista de contactos
class ContactoNotifier extends StateNotifier<AsyncValue<List<Contacto>>> {
  late GestionarContactos usecase;

  ContactoNotifier() : super(const AsyncLoading()) {
    cargar();
  }

  Future<void> cargar() async {
    try {
      state = const AsyncLoading();
      final db = DriftService.instance;
      usecase = GestionarContactos(
        ContactoRepositoryImpl(
          ContactoLocalDataSource(db),
        ),
      );
      state = AsyncData(await usecase.listar());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> agregar(Contacto c) async {
    await usecase.agregar(c);
    await cargar();
  }

  Future<void> actualizar(Contacto c) async {
    await usecase.actualizar(c);
    await cargar();
  }

  Future<void> eliminar(int id) async {
    await usecase.eliminar(id);
    await cargar();
  }

  Future<void> toggleFavorito(Contacto contacto) async {
    await usecase.toggleFavorito(contacto.id!, !contacto.esFavorito);
    await cargar();
  }

  /// Filtra contactos por búsqueda
  List<Contacto> filtrar(List<Contacto> contactos, String query) {
    if (query.isEmpty) return contactos;
    final lowerQuery = query.toLowerCase();
    return contactos.where((c) => 
      c.nombre.toLowerCase().contains(lowerQuery) ||
      c.telefono.contains(query) ||
      c.email.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}

/// Notifier para la lista de favoritos
class FavoritosNotifier extends StateNotifier<AsyncValue<List<Contacto>>> {
  late GestionarContactos usecase;

  FavoritosNotifier() : super(const AsyncLoading()) {
    cargar();
  }

  Future<void> cargar() async {
    try {
      state = const AsyncLoading();
      final db = DriftService.instance;
      usecase = GestionarContactos(
        ContactoRepositoryImpl(
          ContactoLocalDataSource(db),
        ),
      );
      state = AsyncData(await usecase.listarFavoritos());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleFavorito(Contacto contacto) async {
    await usecase.toggleFavorito(contacto.id!, !contacto.esFavorito);
    await cargar();
  }
}

/// Provider para manejar los grupos
final gruposProvider = StateNotifierProvider<GruposNotifier, AsyncValue<List<GrupoData>>>(
  (ref) => GruposNotifier(),
);

/// Clase para representar un grupo con sus contactos
class GrupoData {
  final int id;
  final String nombre;
  final String descripcion;
  final String icono;
  final int color;
  final List<int> contactoIds;

  GrupoData({
    required this.id,
    required this.nombre,
    this.descripcion = '',
    this.icono = 'group',
    this.color = 0xFF4CAF50,
    this.contactoIds = const [],
  });

  GrupoData copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? icono,
    int? color,
    List<int>? contactoIds,
  }) {
    return GrupoData(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      contactoIds: contactoIds ?? this.contactoIds,
    );
  }
}

/// Notifier para la lista de grupos
class GruposNotifier extends StateNotifier<AsyncValue<List<GrupoData>>> {
  GruposNotifier() : super(const AsyncLoading()) {
    cargar();
  }

  Future<void> cargar() async {
    try {
      state = const AsyncLoading();
      final db = DriftService.instance;
      final grupos = await db.obtenerGrupos();
      state = AsyncData(grupos.map((g) => GrupoData(
        id: g.id,
        nombre: g.nombre,
        descripcion: g.descripcion,
        icono: g.icono,
        color: g.color,
        contactoIds: _parseContactoIds(g.contactoIds),
      )).toList());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  List<int> _parseContactoIds(String json) {
    if (json.isEmpty || json == '[]') return [];
    try {
      final cleaned = json.replaceAll('[', '').replaceAll(']', '');
      if (cleaned.isEmpty) return [];
      return cleaned.split(',').map((s) => int.parse(s.trim())).toList();
    } catch (_) {
      return [];
    }
  }

  String _encodeContactoIds(List<int> ids) {
    return '[${ids.join(',')}]';
  }

  Future<void> agregar(String nombre, {String descripcion = '', int color = 0xFF4CAF50}) async {
    final db = DriftService.instance;
    await db.insertarGrupo(GruposCompanion.insert(
      nombre: nombre,
      descripcion: Value(descripcion),
      color: Value(color),
    ));
    await cargar();
  }

  Future<void> eliminar(int id) async {
    final db = DriftService.instance;
    await db.eliminarGrupo(id);
    await cargar();
  }

  Future<void> agregarContactoAGrupo(int grupoId, int contactoId) async {
    final db = DriftService.instance;
    final grupo = await db.obtenerGrupoPorId(grupoId);
    if (grupo != null) {
      final ids = _parseContactoIds(grupo.contactoIds);
      if (!ids.contains(contactoId)) {
        ids.add(contactoId);
        await db.actualizarGrupo(grupo.copyWith(
          contactoIds: _encodeContactoIds(ids),
        ));
        await cargar();
      }
    }
  }

  Future<void> quitarContactoDeGrupo(int grupoId, int contactoId) async {
    final db = DriftService.instance;
    final grupo = await db.obtenerGrupoPorId(grupoId);
    if (grupo != null) {
      final ids = _parseContactoIds(grupo.contactoIds);
      ids.remove(contactoId);
      await db.actualizarGrupo(grupo.copyWith(
        contactoIds: _encodeContactoIds(ids),
      ));
      await cargar();
    }
  }
}
