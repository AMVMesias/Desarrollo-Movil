import '../../domain/entities/game.dart';
import '../datasources/base_datasource.dart';
import 'base_repository.dart';

class GameRepositoryImpl extends BaseRepository<GameEntity> {
  GameRepositoryImpl(BaseDatasource<GameEntity> datasource) : super(datasource);
}
