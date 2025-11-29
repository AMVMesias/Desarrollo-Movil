import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import 'base_datasource.dart';

class CharactersApiDataSource implements BaseDataSource {
  final String base = 'https://thronesapi.com/api/v2/Characters';
  @override
  Future<List<CharacterModel>> fetchCharacters() async {
    final uri = Uri.parse(base);
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Error fetching characters: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.map((e) => CharacterModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<CharacterModel> fetchCharacterById(int id) async {
    final uri = Uri.parse('$base/$id');
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Error fetching character $id: ${resp.statusCode}');
    }
    final Map<String, dynamic> data = json.decode(resp.body);
    return CharacterModel.fromJson(data);
  }

  Future<CharacterModel> createCharacter(Map<String, dynamic> payload) async {
    final uri = Uri.parse(base);
    final resp = await http.post(uri, body: json.encode(payload), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode != 201 && resp.statusCode != 200) {
      throw Exception('Error creating character: ${resp.statusCode}');
    }
    final Map<String, dynamic> data = json.decode(resp.body);
    return CharacterModel.fromJson(data);
  }
}
