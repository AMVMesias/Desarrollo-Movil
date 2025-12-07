import 'package:flutter/material.dart';
import '../../domain/entities/base_entity.dart';
import '../../domain/usecases/get_data_usecase.dart';

class BaseViewModel<T extends BaseEntity> extends ChangeNotifier {
  final GetDataUseCase<T> useCase;

  BaseViewModel(this.useCase);

  List<T> items = [];
  bool loading = false;
  String? error;

  Future<void> loadData() async {
    loading = true;
    notifyListeners();

    try {
      print('🔄 Loading data...');
      items = await useCase();
      print('✅ Data loaded: ${items.length} items');
    } catch (e) {
      error = e.toString();
      print('❌ Error loading data: $error');
    }

    loading = false;
    notifyListeners();
  }
}
