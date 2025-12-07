import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repository/freetogame_datasource.dart';
import 'data/repository/game_repository.dart';
import 'domain/usecases/get_data_usecase.dart';
import 'presentation/viewmodels/game_viewmodel.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/views/game_detail_page.dart';
import 'domain/entities/game.dart';
import 'temas/tema_general.dart';

void main() {
  final datasource = FreeToGameDataSource();
  final repository = GameRepositoryImpl(datasource);
  final useCase = GetDataUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameViewModel(useCase)..loadData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: TemaGeneral.oscuro,
        initialRoute: "/",
        routes: AppRoutes.routes,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.gameDetail) {
            final game = settings.arguments as GameEntity;
            return MaterialPageRoute(
              builder: (context) => GameDetailPage(game: game),
            );
          }
          return null;
        },
      ),
    ),
  );
}
