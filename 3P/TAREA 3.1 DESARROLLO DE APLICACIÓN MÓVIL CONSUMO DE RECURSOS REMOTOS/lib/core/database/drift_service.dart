import '../../data/database/database.dart';

/// Servicio de base de datos Drift (ORM)
class DriftService {
  static AppDatabase? _db;

  /// Inicializa y retorna la instancia singleton de la base de datos
  static AppDatabase get instance {
    _db ??= AppDatabase();
    return _db!;
  }

  /// Cierra la conexión a la base de datos
  static Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
