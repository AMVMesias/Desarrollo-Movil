import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/viewmodels/character_viewmodel.dart';
import 'data/repositories/character_repository_impl.dart';
import 'data/datasource/characters_api_datasource.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/themes/app_theme.dart';

void main() {
  // Inyección de dependencias para Characters
  final charactersDs = CharactersApiDataSource();
  final charactersRepo = CharacterRepositoryImpl(charactersDs);
  final characterVm = CharacterViewModel(charactersRepo)..loadCharacters();

  runApp(MyApp(characterVm: characterVm));
}

class MyApp extends StatelessWidget {
  final CharacterViewModel characterVm;

  const MyApp({super.key, required this.characterVm});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: characterVm),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Game of Thrones - API",
        theme: AppTheme.theme,
        routes: AppRoutes.routes,
      ),
    );
  }
}
