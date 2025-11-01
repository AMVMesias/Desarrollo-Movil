import 'package:flutter/material.dart';
import 'package:laboratorio2/views/widgets/index.dart';
import 'package:laboratorio2/utils/input_validator.dart';

/// Página: Caja registradora (Ejercicio 4.12)
class CashRegisterPage extends StatefulWidget {
  const CashRegisterPage({super.key});

  @override
  State<CashRegisterPage> createState() => _CashRegisterPageState();
}

class _CashRegisterPageState extends State<CashRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, double> _billetes = {
    'Billete 5': 5.0,
    'Billete 10': 10.0,
    'Billete 20': 20.0,
    'Billete 50': 50.0,
    'Billete 100': 100.0,
  };

  final Map<String, double> _monedas = {
    'Moneda 1 centavo': 0.01,
    'Moneda 5 centavos': 0.05,
    'Moneda 10 centavos': 0.10,
    'Moneda 25 centavos': 0.25,
    'Moneda 50 centavos': 0.50,
    'Moneda 1 dolar': 1.0,
  };

  final Map<String, TextEditingController> _controllers = {};
  double? _total;

  @override
  void initState() {
    super.initState();
    for (final k in _billetes.keys) {
      _controllers[k] = TextEditingController();
    }
    for (final k in _monedas.keys) {
      _controllers[k] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  int _parseQty(String? text) => InputValidator.parseQtyOrZero(text);

  void _calcularEnPantalla() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    double total = 0.0;
    for (final entry in _billetes.entries) {
      final qty = _parseQty(_controllers[entry.key]?.text);
      total += (qty <= 0) ? 0 : qty * entry.value;
    }
    for (final entry in _monedas.entries) {
      final qty = _parseQty(_controllers[entry.key]?.text);
      total += (qty <= 0) ? 0 : qty * entry.value;
    }

    setState(() {
      _total = double.parse(total.toStringAsFixed(2));
    });
  }

  void _navegarResultado() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    double total = 0.0;
    for (final entry in _billetes.entries) {
      final qty = _parseQty(_controllers[entry.key]?.text);
      total += (qty <= 0) ? 0 : qty * entry.value;
    }
    for (final entry in _monedas.entries) {
      final qty = _parseQty(_controllers[entry.key]?.text);
      total += (qty <= 0) ? 0 : qty * entry.value;
    }

    final resultado = total.toStringAsFixed(2);
    Navigator.pushNamed(context, '/resultado', arguments: resultado);
  }

  Widget _buildRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140, minWidth: 100),
            child: NumericInput(
              controller: controller,
              label: '',
              hint: '0',
              type: NumericInputType.integer,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Principal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  const Text('Ingrese la cantidad de cada denominación:', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Billetes', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ..._billetes.keys.map((k) => _buildRow(k, _controllers[k]!)),
                        const SizedBox(height: 12),
                        const Text('Monedas', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ..._monedas.keys.map((k) => _buildRow(k, _controllers[k]!)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Boton(
                    texto: 'Calcular total en pantalla',
                    expanded: true,
                    onPressed: _calcularEnPantalla,
                  ),
                  const SizedBox(height: 8),
                  Boton(
                    texto: 'Ver total en pantalla Resultado',
                    expanded: true,
                    onPressed: _navegarResultado,
                  ),
                  const SizedBox(height: 12),
                  if (_total != null)
                    Center(child: Text('Total: ${_total!.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
