import 'package:flutter/material.dart';
import 'investment_input_view.dart';
import 'home_page.dart';
import 'cash_register_page.dart';
import 'sales_analysis_page.dart';
import 'sale_input_page.dart';

class SelectorPage extends StatelessWidget {
  const SelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorio 2'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InvestmentInputView()),
              ),
              child: const Text('Ejercicio 4.9: Calculadora de Inversión'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              ),
              child: const Text('Ejercicio 4.10: Escuela San Felipe'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CashRegisterPage()),
              ),
              child: const Text('Ejercicio 4.12: Caja registradora'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SalesAnalysisPage()),
              ),
              child: const Text('Ejercicio 4.13: Análisis de ventas'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SaleInputPage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              child: const Text('Problema 1: Calcular IVA y Factura'),
            ),
          ],
        ),
      ),
    );
  }
}
