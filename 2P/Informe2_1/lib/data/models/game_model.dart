import 'dart:convert';

import '../../domain/entities/game.dart';

class GameModel extends GameEntity {
  GameModel({
    required int id,
    required String title,
    required String thumbnail,
    required String shortDescription,
    required String gameUrl,
    required String genre,
    required String platform,
    required String publisher,
    required String developer,
    required String releaseDate,
    required String freetogameProfileUrl,
  }) : super(
          id: id,
          title: title,
          thumbnail: thumbnail,
          shortDescription: shortDescription,
          gameUrl: gameUrl,
          genre: genre,
          platform: platform,
          publisher: publisher,
          developer: developer,
          releaseDate: releaseDate,
          freetogameProfileUrl: freetogameProfileUrl,
        );

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'] is int ? map['id'] as int : int.tryParse(map['id'].toString()) ?? 0,
      title: map['title']?.toString() ?? '',
      thumbnail: map['thumbnail']?.toString() ?? '',
      shortDescription: map['short_description']?.toString() ?? '',
      gameUrl: map['game_url']?.toString() ?? '',
      genre: map['genre']?.toString() ?? '',
      platform: map['platform']?.toString() ?? '',
      publisher: map['publisher']?.toString() ?? '',
      developer: map['developer']?.toString() ?? '',
      releaseDate: map['release_date']?.toString() ?? '',
      freetogameProfileUrl: map['freetogame_profile_url']?.toString() ?? '',
    );
  }

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'short_description': shortDescription,
      'game_url': gameUrl,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': releaseDate,
      'freetogame_profile_url': freetogameProfileUrl,
    };
  }

  String toJson() => json.encode(toMap());
}
