import '../models/character_model.dart';

abstract class BaseDataSource {
  /// Devuelve la lista de personajes.
  Future<List<CharacterModel>> fetchCharacters();
}
