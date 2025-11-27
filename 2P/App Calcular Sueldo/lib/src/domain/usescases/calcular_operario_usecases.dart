import '../entities/operario.dart';
import '../entities/resultado_operario.dart';

class CalcularAumentoUseCase {
  ResultadoOperario ejecutar(Operario op){

    double aumento = 0;
    
    if(op.sueldo < 500){
      if(op.antiguedad >= 10){
        aumento = op.sueldo * 0.20;  // 20% para 10+ años
      } else if(op.antiguedad >= 5){
        aumento = op.sueldo * 0.15;  // 15% para 5-9 años
      } else if(op.antiguedad >= 2){
        aumento = op.sueldo * 0.10;  // 10% para 2-4 años
      } else {
        aumento = op.sueldo * 0.05;  // 5% para menos de 2 años
      }
    }
    final sueldoFinal = op.sueldo + aumento;
    return ResultadoOperario(aumento: aumento, sueldoFinal: sueldoFinal);
  }
}