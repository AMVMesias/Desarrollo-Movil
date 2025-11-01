import '../models/investment_model.dart';

// Ejercicio 4.9
class InvestmentController {
  late InvestmentModel _model;

  void setInvestmentData({required double monthlyDeposit, required int years}) {
    _model = InvestmentModel(monthlyDeposit: monthlyDeposit, years: years);
  }

  List<double> calculateYearlyInvestment() {
    return _model.calculateYearlyInvestment();
  }
}
