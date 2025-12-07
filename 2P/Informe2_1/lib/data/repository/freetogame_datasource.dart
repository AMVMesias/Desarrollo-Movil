import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/game_model.dart';
import '../datasources/base_datasource.dart';


class FreeToGameDataSource extends BaseDatasource<GameModel> {
  // Usar proxy CORS solo en Web, en móvil usar la API directa
  String get url => kIsWeb 
      ? 'https://corsproxy.io/?https://www.freetogame.com/api/games'
      : 'https://www.freetogame.com/api/games';

  @override
  Future<List<GameModel>> fetchData() async {
    try {
      print('🌐 Fetching data from: $url');
      //hacer la peticion http
      final uri = Uri.parse(url);
      final resp = await http.get(uri);

      print('📡 Response status: ${resp.statusCode}');

      //validaciones 404
      if (resp.statusCode != 200) {
        throw Exception('Failed to load data: ${resp.statusCode}');
      }

      //decodificar un json =jsonDecode
      final List data = jsonDecode(resp.body);
      print('📦 Games fetched: ${data.length}');
      //Lista
      return data.map((json) => GameModel.fromJson(json)).toList();
    } catch (e) {
      print('❌ Error in fetchData: $e');
      rethrow;
    }
  }

}
