

class EmpleadoModel {
  final int edad;
  final int antiguedad;

  EmpleadoModel(this.edad, this.antiguedad);

  double calcularSueldo() {
    double sueldoBase = 35000;
    double bonoEdad = edad.toDouble();
    
    // Calcular la suma de 1+2+3+...+antiguedad
    int sumaAntiguedad = 0;
    for (int i = 1; i <= antiguedad; i++) {
      sumaAntiguedad += i;
    }
    
    double bonoAntiguedad = 100 * sumaAntiguedad.toDouble();
    
    return sueldoBase + bonoEdad + bonoAntiguedad;
  }
}
