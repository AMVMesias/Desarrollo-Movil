import 'package:flutter/material.dart';
import 'package:laboratorio2/views/widgets/index.dart';
import 'package:laboratorio2/models/sales_analysis_model.dart';
import 'package:laboratorio2/utils/input_validator.dart';

/// Página: Análisis de ventas por rangos (Ejercicio 4.13)
class SalesAnalysisPage extends StatefulWidget {
  const SalesAnalysisPage({super.key});

  @override
  State<SalesAnalysisPage> createState() => _SalesAnalysisPageState();
}

class _SalesAnalysisPageState extends State<SalesAnalysisPage> {
  final _countController = TextEditingController();
  final _amountController = TextEditingController();

  String? _error;
  SalesAnalysisResult? _result;

  int? _expectedCount;
  int _currentIndex = 0;
  final List<double> _ventas = [];

  @override
  void dispose() {
    _countController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _startEntry() {
    setState(() {
      _error = null;
      _ventas.clear();
      _currentIndex = 0;
      _result = null;
    });

    final text = _countController.text.trim();
    final n = InputValidator.parseQtyOrZero(text);
    if (n <= 0) {
      setState(() {
        _error = 'Ingrese un número válido de ventas (entero mayor que 0).';
      });
      return;
    }

    setState(() {
      _expectedCount = n;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Listo: se esperan $n ventas. Ingrese los montos uno por uno.'))
    );
  }

  void _addVenta() {
    setState(() {
      _error = null;
    });
    final raw = _amountController.text.trim();
    // Valida: no vacío
    if (raw.isEmpty) {
      setState(() {
        _error = 'Ingrese el monto de la venta.';
      });
      return;
    }

    // Valida: número válido > 0
    final v = InputValidator.parseDoubleOrZero(raw);
    if (v <= 0) {
      setState(() {
        _error = 'Monto inválido. Ingrese un número válido.';
      });
      return;
    }

    _ventas.add(v);
    _amountController.clear();
    _currentIndex++;

    if (_expectedCount != null && _currentIndex >= _expectedCount!) {
      final res = SalesAnalysisResult.analyze(_ventas);
      setState(() {
        _result = res;
        _expectedCount = null;
      });
    }
  }

  void _reset() {
    setState(() {
      _error = null;
      _result = null;
      _expectedCount = null;
      _ventas.clear();
      _currentIndex = 0;
      _countController.clear();
      _amountController.clear();
    });
  }

  Widget _buildResultRow(BuildContext context, String label, int count, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Cantidad: $count'),
            Text('Monto: ${amount.toStringAsFixed(2)}'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 4.13')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_expectedCount == null && _result == null) ...[
                    const Text('¿Cuántas ventas realizó el vendedor?'),
                    const SizedBox(height: 8),
                    NumericInput(
                      controller: _countController,
                      label: 'Número de ventas',
                      hint: 'Ej: 5',
                      type: NumericInputType.integer,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: Boton(texto: 'Comenzar', expanded: true, onPressed: _startEntry)),
                        const SizedBox(width: 8),
                        Boton(texto: 'Limpiar', expanded: false, onPressed: _reset),
                      ],
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                  ],

                  if (_expectedCount != null) ...[
                    Text('Ingresando venta ${_currentIndex + 1} de $_expectedCount'),
                    const SizedBox(height: 8),
                    NumericInput(
                      controller: _amountController,
                      label: 'Monto de la venta',
                      hint: 'Ej: 12500.50',
                      type: NumericInputType.decimal,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: Boton(texto: 'Agregar', expanded: true, onPressed: _addVenta)),
                        const SizedBox(width: 8),
                        Boton(texto: 'Cancelar', expanded: false, onPressed: _reset),
                      ],
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                  ],

                  if (_result != null) ...[
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Resumen de ventas', style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 12),
                            _buildResultRow(context, 'Ventas <= 10000', _result!.countLessOrEqual10000, _result!.sumLessOrEqual10000),
                            const SizedBox(height: 8),
                            _buildResultRow(context, 'Ventas > 10000 y < 20000', _result!.countBetween10000And20000, _result!.sumBetween10000And20000),
                            const SizedBox(height: 8),
                            _buildResultRow(context, 'Ventas >= 20000', _result!.countGreaterOrEqual20000, _result!.sumGreaterOrEqual20000),

                            const Divider(height: 20),
                            Text('Monto global', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 6),
                            Text(_result!.total.toStringAsFixed(2), style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: Boton(texto: 'Nueva sesión', expanded: true, onPressed: _reset)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
