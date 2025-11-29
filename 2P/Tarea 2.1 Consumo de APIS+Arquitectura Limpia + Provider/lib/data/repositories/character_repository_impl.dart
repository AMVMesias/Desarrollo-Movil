import '../datasource/characters_api_datasource.dart';
import '../models/character_model.dart';

class CharacterRepositoryImpl {
  final CharactersApiDataSource _ds;

  CharacterRepositoryImpl(this._ds);

  Future<List<CharacterModel>> getAllCharacters() => _ds.fetchCharacters();

  Future<CharacterModel> getCharacterById(int id) => _ds.fetchCharacterById(id);

  Future<CharacterModel> createCharacter(Map<String, dynamic> payload) => _ds.createCharacter(payload);
}
