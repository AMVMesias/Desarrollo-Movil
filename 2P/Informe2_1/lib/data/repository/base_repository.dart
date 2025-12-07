//usecase llamar repository
//repository llama a darasource
//datasource llama a la api


import '../../domain/entities/base_entity.dart';
import '../datasources/base_datasource.dart';

abstract class BaseRepository<T extends BaseEntity> {
  final BaseDatasource<T> datasource;

  BaseRepository(this.datasource);

  Future<List<T>> getAll() async {
    return await datasource.fetchData();
  }
}

//List view con scroll y ver detalle
