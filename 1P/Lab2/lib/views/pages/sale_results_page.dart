import 'package:flutter/material.dart';

class SaleResultsPage extends StatelessWidget {
  final double subtotal;
  final double iva;
  final double descuento;
  final double total;
  final double sueldoVendedor;

  const SaleResultsPage({
    super.key,
    required this.subtotal,
    required this.iva,
    required this.descuento,
    required this.total,
    required this.sueldoVendedor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la Venta'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Factura',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(height: 20),
                        _buildRow('Subtotal:', '\$${subtotal.toStringAsFixed(2)}'),
                        _buildRow('IVA (15%):', '\$${iva.toStringAsFixed(2)}'),
                        if (descuento > 0)
                          _buildRow('Descuento (20%):', '-\$${descuento.toStringAsFixed(2)}', color: Colors.green),
                        const Divider(height: 20),
                        _buildRow(
                          'Total a pagar:',
                          '\$${total.toStringAsFixed(2)}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  color: Colors.yellow[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sueldo del Vendedor',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(height: 20),
                        _buildRow(
                          'Comisión:',
                          '\$${sueldoVendedor.toStringAsFixed(2)}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
