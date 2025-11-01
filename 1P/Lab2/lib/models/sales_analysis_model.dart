// Ejercicio 4.13
class SalesAnalysisResult {
	final int countLessOrEqual10000;
	final double sumLessOrEqual10000;
	final int countBetween10000And20000;
	final double sumBetween10000And20000;
	final int countGreaterOrEqual20000;
	final double sumGreaterOrEqual20000;

	double get total =>
			sumLessOrEqual10000 + sumBetween10000And20000 + sumGreaterOrEqual20000;

	const SalesAnalysisResult({
		required this.countLessOrEqual10000,
		required this.sumLessOrEqual10000,
		required this.countBetween10000And20000,
		required this.sumBetween10000And20000,
		required this.countGreaterOrEqual20000,
		required this.sumGreaterOrEqual20000,
	});

	// Rango 1: <= $10,000 | Rango 2: > $10,000 y < $20,000 | Rango 3: >= $20,000
	static SalesAnalysisResult analyze(List<double> ventas) {
		int c1 = 0;
		double s1 = 0.0;
		int c2 = 0;
		double s2 = 0.0;
		int c3 = 0;
		double s3 = 0.0;

		for (final v in ventas) {
			if (v <= 10000) {
				c1++; // Cuenta venta en rango 1
				s1 += v; // Suma venta en rango 1
			} else if (v > 10000 && v < 20000) {
				c2++; // Cuenta venta en rango 2
				s2 += v; // Suma venta en rango 2
			} else {
				c3++; // Cuenta venta en rango 3 (>= 20000)
				s3 += v; // Suma venta en rango 3
			}
		}

	return SalesAnalysisResult(
		countLessOrEqual10000: c1,
		sumLessOrEqual10000: s1,
		countBetween10000And20000: c2,
		sumBetween10000And20000: s2,
		countGreaterOrEqual20000: c3,
		sumGreaterOrEqual20000: s3,
	);
  }
}