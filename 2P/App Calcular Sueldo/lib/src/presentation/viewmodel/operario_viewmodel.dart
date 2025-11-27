import 'package:flutter/material.dart';
import '../../domain/entities/resultado_operario.dart';
import '../../domain/entities/operario.dart';
import '../../domain/usescases/calcular_operario_usecases.dart';

class OperarioViewModel extends ChangeNotifier{
  final CalcularAumentoUseCase _useCase;

  OperarioViewModel(this._useCase);

  ResultadoOperario? _resultado;
  ResultadoOperario? get resultado => _resultado;

  final List<ResultadoOperario> _historial = [];
  List<ResultadoOperario> get historial => _historial;


  void calcular(double sueldo, int antiguedad){
    final op = Operario(sueldo: sueldo, antiguedad: antiguedad);
    _resultado = _useCase.ejecutar(op);
    
    if (_resultado != null) {
      _historial.add(_resultado!);
    }

    notifyListeners();
  }

}
