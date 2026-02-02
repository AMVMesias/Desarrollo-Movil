import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Tabla de Contactos para Drift ORM
class Contactos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  TextColumn get telefono => text().withDefault(const Constant(''))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get foto => text().withDefault(const Constant(''))();
  BoolColumn get esFavorito => boolean().withDefault(const Constant(false))();
}

/// Tabla de Grupos para organizar contactos
class Grupos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  TextColumn get icono => text().withDefault(const Constant('group'))();
  IntColumn get color => integer().withDefault(const Constant(0xFF4CAF50))();
  // Lista de IDs de contactos como JSON string
  TextColumn get contactoIds => text().withDefault(const Constant('[]'))();
}

/// Base de datos de la aplicación usando Drift ORM
@DriftDatabase(tables: [Contactos, Grupos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(grupos);
        }
      },
    );
  }

  // ============ OPERACIONES CRUD CONTACTOS ============

  /// Obtiene todos los contactos ordenados por nombre
  Future<List<Contacto>> obtenerContactos() {
    return (select(contactos)..orderBy([(t) => OrderingTerm.asc(t.nombre)])).get();
  }

  /// Obtiene solo los contactos favoritos
  Future<List<Contacto>> obtenerFavoritos() {
    return (select(contactos)
          ..where((t) => t.esFavorito.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.nombre)]))
        .get();
  }

  /// Observa cambios en los contactos (Stream reactivo)
  Stream<List<Contacto>> watchContactos() {
    return (select(contactos)..orderBy([(t) => OrderingTerm.asc(t.nombre)])).watch();
  }

  /// Inserta un nuevo contacto
  Future<int> insertarContacto(ContactosCompanion contacto) {
    return into(contactos).insert(contacto);
  }

  /// Actualiza un contacto existente
  Future<bool> actualizarContacto(Contacto contacto) {
    return update(contactos).replace(contacto);
  }

  /// Elimina un contacto por su ID
  Future<int> eliminarContacto(int id) {
    return (delete(contactos)..where((t) => t.id.equals(id))).go();
  }

  /// Cambia el estado de favorito
  Future<int> toggleFavorito(int id, bool nuevoEstado) {
    return (update(contactos)..where((t) => t.id.equals(id)))
        .write(ContactosCompanion(esFavorito: Value(nuevoEstado)));
  }

  // ============ OPERACIONES CRUD GRUPOS ============

  /// Obtiene todos los grupos ordenados por nombre
  Future<List<Grupo>> obtenerGrupos() {
    return (select(grupos)..orderBy([(t) => OrderingTerm.asc(t.nombre)])).get();
  }

  /// Observa cambios en los grupos (Stream reactivo)
  Stream<List<Grupo>> watchGrupos() {
    return (select(grupos)..orderBy([(t) => OrderingTerm.asc(t.nombre)])).watch();
  }

  /// Inserta un nuevo grupo
  Future<int> insertarGrupo(GruposCompanion grupo) {
    return into(grupos).insert(grupo);
  }

  /// Actualiza un grupo existente
  Future<bool> actualizarGrupo(Grupo grupo) {
    return update(grupos).replace(grupo);
  }

  /// Elimina un grupo por su ID
  Future<int> eliminarGrupo(int id) {
    return (delete(grupos)..where((t) => t.id.equals(id))).go();
  }

  /// Obtiene un grupo por su ID
  Future<Grupo?> obtenerGrupoPorId(int id) {
    return (select(grupos)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}

/// Abre la conexión a la base de datos SQLite
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'contactos_ddd.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
