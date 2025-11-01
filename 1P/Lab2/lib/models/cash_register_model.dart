// Ejercicio 4.12

// Total = billetes + monedas
double calcularTotalCaja(int billetesTotal, double monedasTotal) {
  if (billetesTotal < 0) {
    throw ArgumentError('Total de billetes no puede ser negativo'); // Valida: >= 0
  }
  if (monedasTotal < 0) {
    throw ArgumentError('Total de monedas no puede ser negativo'); // Valida: >= 0
  }

  return billetesTotal + monedasTotal;
}

double calcularTotalSimple(double billetesAsDouble, double monedasTotal) {
  final billetesInt = billetesAsDouble.toInt();
  return calcularTotalCaja(billetesInt, monedasTotal);
}

// Total = Σ(denominación × cantidad)
double calcularTotalDesdeDenominaciones(Map<double,int> billetes, Map<double,int> monedas) {
  double total = 0.0;
  billetes.forEach((valor, cantidad) {
    if (cantidad < 0) throw ArgumentError('Cantidad negativa para billete $valor'); // Valida: >= 0
    total += valor * cantidad; // valor × cantidad
  });
  monedas.forEach((valor, cantidad) {
    if (cantidad < 0) throw ArgumentError('Cantidad negativa para moneda $valor'); // Valida: >= 0
    total += valor * cantidad; // valor × cantidad
  });
  return total;
}
