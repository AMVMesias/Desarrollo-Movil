import 'package:flutter/foundation.dart';

// Ejercicio 4.9
class InvestmentModel {
  double monthlyDeposit;
  int years;
  double annualInterestRate;

  InvestmentModel({
    required this.monthlyDeposit,
    required this.years,
    this.annualInterestRate = 0.10, // Tasa fija 10%
  });

  // Calcula: año = (12 depósitos) + (total × 0.10)
  List<double> calculateYearlyInvestment() {
    List<double> yearlyTotals = [];
    double totalInvestment = 0;

    for (int year = 1; year <= years; year++) {
      for (int month = 1; month <= 12; month++) {
        totalInvestment += monthlyDeposit; // Suma 12 depósitos
      }
      totalInvestment += totalInvestment * annualInterestRate; // Total × 0.10
      yearlyTotals.add(totalInvestment);
    }

    return yearlyTotals;
  }
}
