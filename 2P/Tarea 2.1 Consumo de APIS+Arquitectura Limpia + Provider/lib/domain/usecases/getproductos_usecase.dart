import '../entities/producto_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetProductosUseCase {
  final BaseRepository repository;

  GetProductosUseCase(this.repository);

  Future<List<ProductoEntity>> call() async {
    return await repository.getProductos();
  }
}
