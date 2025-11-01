import 'package:flutter/material.dart';
import '../../controllers/sale_controller.dart';
import '../widgets/atoms/custom_text_field.dart';
import '../widgets/atoms/custom_button.dart';
import 'sale_results_page.dart';

class SaleInputPage extends StatefulWidget {
  const SaleInputPage({super.key});

  @override
  State<SaleInputPage> createState() => _SaleInputPageState();
}

class _SaleInputPageState extends State<SaleInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _comisionController = TextEditingController(text: '10');
  final _controller = SaleController();

  @override
  void dispose() {
    _montoController.dispose();
    _comisionController.dispose();
    super.dispose();
  }

  void _calcular() {
    if (_formKey.currentState!.validate()) {
      final monto = double.parse(_montoController.text);
      final comision = double.parse(_comisionController.text) / 100;

      _controller.setSaleData(
        montoVenta: monto,
        comisionVendedor: comision,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaleResultsPage(
            subtotal: _controller.getSubtotal(),
            iva: _controller.getIva(),
            descuento: _controller.getDescuento(),
            total: _controller.getTotal(),
            sueldoVendedor: _controller.getSueldoVendedor(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular IVA y Factura'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _montoController,
                labelText: 'Monto de la venta',
                keyboardType: TextInputType.number,
                // Valida: no null, no vacío, número válido, > 0
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un valor';
                  }
                  final n = double.tryParse(value);
                  if (n == null) {
                    return 'Por favor, ingrese un número válido';
                  }
                  if (n <= 0) {
                    return 'El valor debe ser positivo y distinto de cero';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _comisionController,
                labelText: 'Comisión del vendedor (%)',
                keyboardType: TextInputType.number,
                // Valida: no null, no vacío, número válido, entre 0-100
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un valor';
                  }
                  final n = double.tryParse(value);
                  if (n == null) {
                    return 'Por favor, ingrese un número válido';
                  }
                  if (n < 0 || n > 100) {
                    return 'El valor debe estar entre 0 y 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: _calcular,
                text: 'Calcular',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
