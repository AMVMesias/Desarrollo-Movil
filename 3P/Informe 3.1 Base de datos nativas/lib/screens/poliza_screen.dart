import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/poliza_response.dart';
import '../models/poliza_request.dart';
import '../controllers/poliza_controller.dart';
import '../services/poliza_service.dart';
import '../theme/app_theme.dart';

// ============================================================================
// RIVERPOD STATE & NOTIFIER (Integrado en la VIEW)
// ============================================================================

class PolizaState {
  final PolizaResponse? poliza;
  final bool isLoading;
  final bool isCalculated;
  final bool isSaved;
  final String? error;

  PolizaState({
    this.poliza,
    this.isLoading = false,
    this.isCalculated = false,
    this.isSaved = false,
    this.error,
  });

  PolizaState copyWith({
    PolizaResponse? poliza,
    bool? isLoading,
    bool? isCalculated,
    bool? isSaved,
    String? error,
  }) {
    return PolizaState(
      poliza: poliza ?? this.poliza,
      isLoading: isLoading ?? this.isLoading,
      isCalculated: isCalculated ?? this.isCalculated,
      isSaved: isSaved ?? this.isSaved,
      error: error,
    );
  }
}

class PolizaNotifier extends Notifier<PolizaState> {
  late final PolizaController _controller;
  late final PolizaService _service;

  @override
  PolizaState build() {
    _controller = ref.read(_controllerProvider);
    _service = ref.read(_serviceProvider);
    return PolizaState();
  }

  void calcular({
    required String nombre,
    required int edad,
    required double valorAuto,
    required String modelo,
    required int accidentes,
  }) {
    if (!_controller.validarEdad(edad)) {
      state = state.copyWith(error: 'Edad fuera del rango (18-100 años)');
      return;
    }

    final costo = _controller.calcularCostoPoliza(
      valorAuto: valorAuto,
      modelo: modelo,
      edad: edad,
      accidentes: accidentes,
    );

    final poliza = PolizaResponse.fromLocal(
      nombre: nombre,
      edad: edad,
      valor: valorAuto,
      modelo: modelo,
      accidentes: accidentes,
      costo: costo,
    );

    state = state.copyWith(
      poliza: poliza,
      isCalculated: true,
      isSaved: false,
      error: null,
    );
  }

  Future<void> guardar() async {
    if (state.poliza == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = PolizaRequest(
        nombrePropietario: state.poliza!.nombrePropietario,
        edadPropietario: state.poliza!.edadPropietario,
        valorAuto: state.poliza!.valorAuto,
        modeloAuto: state.poliza!.modeloAuto,
        numeroAccidentes: state.poliza!.numeroAccidentes,
        costoTotal: state.poliza!.costoTotal,
      );

      await _service.guardarPoliza(request);
      state = state.copyWith(isLoading: false, isSaved: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Error: $e');
    }
  }

  void limpiar() {
    state = PolizaState();
  }
}

// Riverpod Providers
final _controllerProvider = Provider((ref) => PolizaController());
final _serviceProvider = Provider((ref) => PolizaService());

final polizaProvider = NotifierProvider<PolizaNotifier, PolizaState>(() {
  return PolizaNotifier();
});

// ============================================================================
// VIEW - PANTALLA PRINCIPAL (MVC + RIVERPOD)
// ============================================================================
// Solo maneja la interfaz de usuario
// Usa RIVERPOD para el manejo de estado
// Delega la lógica al CONTROLLER a través del PROVIDER
// ============================================================================

class PolizaScreen extends ConsumerStatefulWidget {
  const PolizaScreen({super.key});

  @override
  ConsumerState<PolizaScreen> createState() => _PolizaScreenState();
}

class _PolizaScreenState extends ConsumerState<PolizaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _valorController = TextEditingController();
  final _accidentesController = TextEditingController();
  
  String _modelo = 'A';
  int _edad = 18;

  @override
  void dispose() {
    _nombreController.dispose();
    _valorController.dispose();
    _accidentesController.dispose();
    super.dispose();
  }

  void _calcular() {
    if (!_formKey.currentState!.validate()) return;

    // Delega al PROVIDER (que usa el CONTROLLER)
    ref.read(polizaProvider.notifier).calcular(
          nombre: _nombreController.text.trim(),
          edad: _edad,
          valorAuto: double.parse(_valorController.text),
          modelo: _modelo,
          accidentes: int.parse(_accidentesController.text),
        );
  }

  void _guardar() {
    ref.read(polizaProvider.notifier).guardar();
  }

  void _limpiar() {
    _nombreController.clear();
    _valorController.clear();
    _accidentesController.clear();
    setState(() {
      _modelo = 'A';
      _edad = 18;
    });
    ref.read(polizaProvider.notifier).limpiar();
  }

  @override
  Widget build(BuildContext context) {
    // RIVERPOD: Observa cambios de estado
    final state = ref.watch(polizaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Pólizas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildInfoCargos(),
              const SizedBox(height: 20),
              _buildFormulario(),
              const SizedBox(height: 20),
              _buildBotones(state),
              const SizedBox(height: 16),
              if (state.error != null) _buildError(state.error!),
              if (state.poliza != null) _buildResultado(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      color: AppTheme.paleGreen,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Problema:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Calcular el costo de una póliza de seguros según:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.primaryGreen, width: 2),
              ),
              child: const Column(
                children: [
                  Text(
                    'Costo Total =',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text('Cargo por valor + Cargo por modelo'),
                  Text('+ Cargo por edad + Cargo por accidentes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCargos() {
    return Card(
      color: AppTheme.paleGreen,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de Cargos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGreen,
              ),
            ),
            const Divider(height: 20),
            _buildCargo('Cargo por valor:', '3.5% del valor del automóvil'),
            const SizedBox(height: 8),
            _buildCargo(
              'Cargo por accidentes:',
              '\$17 por los primeros 3 accidentes y \$21 por cada extra',
            ),
            const SizedBox(height: 12),
            const Text('Cargo por modelo:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTabla([
              ['Modelo', '% del valor'],
              ['A', '1.1%'],
              ['B', '1.2%'],
              ['C', '1.5%'],
            ]),
            const SizedBox(height: 12),
            const Text('Cargo por edad:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTabla([
              ['Edad', 'Cargo'],
              ['>=18 y <24 años', '\$360'],
              ['>=24 y <53 años', '\$240'],
              ['>=53 o más años', '\$430'],
            ]),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.lightGreen.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: AppTheme.darkGreen, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Nota: Solo se asegura personas de 18-100 años',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCargo(String titulo, String texto) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.lightGreen.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(texto, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTabla(List<List<String>> datos) {
    return Table(
      border: TableBorder.all(color: AppTheme.primaryGreen),
      children: datos.map((fila) {
        final esHeader = fila == datos.first;
        return TableRow(
          decoration: esHeader
              ? BoxDecoration(color: AppTheme.lightGreen)
              : null,
          children: fila.map((celda) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                celda,
                style: TextStyle(
                  fontWeight: esHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildFormulario() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Datos para Calcular',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGreen,
              ),
            ),
            const Divider(height: 20),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Propietario',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryGreen),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Edad:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Chip(
                        label: Text('$_edad años'),
                        backgroundColor: AppTheme.lightGreen,
                      ),
                    ],
                  ),
                  Slider(
                    value: _edad.toDouble(),
                    min: 18,
                    max: 100,
                    divisions: 82,
                    label: '$_edad años',
                    onChanged: (v) => setState(() => _edad = v.toInt()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _valorController,
              decoration: const InputDecoration(
                labelText: 'Valor del Automóvil (\$)',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v?.isEmpty ?? true) return 'Requerido';
                if (double.tryParse(v!) == null) return 'Número inválido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryGreen),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Modelo del Automóvil:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ListTile(
                    title: const Text('Modelo A (1.1%)'),
                    leading: Radio<String>(
                      value: 'A',
                      groupValue: _modelo,
                      onChanged: (v) => setState(() => _modelo = v!),
                    ),
                    onTap: () => setState(() => _modelo = 'A'),
                  ),
                  ListTile(
                    title: const Text('Modelo B (1.2%)'),
                    leading: Radio<String>(
                      value: 'B',
                      groupValue: _modelo,
                      onChanged: (v) => setState(() => _modelo = v!),
                    ),
                    onTap: () => setState(() => _modelo = 'B'),
                  ),
                  ListTile(
                    title: const Text('Modelo C (1.5%)'),
                    leading: Radio<String>(
                      value: 'C',
                      groupValue: _modelo,
                      onChanged: (v) => setState(() => _modelo = v!),
                    ),
                    onTap: () => setState(() => _modelo = 'C'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _accidentesController,
              decoration: const InputDecoration(
                labelText: 'Número de Accidentes',
                prefixIcon: Icon(Icons.car_crash),
              ),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v?.isEmpty ?? true) return 'Requerido';
                final n = int.tryParse(v!);
                if (n == null || n < 0) return 'Número inválido';
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotones(PolizaState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: state.isLoading ? null : _calcular,
                icon: const Icon(Icons.calculate),
                label: const Text('CALCULAR'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _limpiar,
                icon: const Icon(Icons.clear),
                label: const Text('LIMPIAR'),
              ),
            ),
          ],
        ),
        if (state.isCalculated && !state.isSaved)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ElevatedButton.icon(
              onPressed: state.isLoading ? null : _guardar,
              icon: state.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Icon(Icons.save),
              label: const Text('GUARDAR EN BD'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.successGreen,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildError(String error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(child: Text(error, style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  Widget _buildResultado(PolizaState state) {
    final p = state.poliza!;
    
    return Card(
      elevation: 4,
      color: AppTheme.paleGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppTheme.primaryGreen, width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: AppTheme.successGreen, size: 32),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Resultado',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                if (state.isSaved)
                  Chip(
                    label: const Text('Guardado', style: TextStyle(color: Colors.white)),
                    backgroundColor: AppTheme.successGreen,
                    avatar: const Icon(Icons.cloud_done, color: Colors.white, size: 18),
                  ),
              ],
            ),
            const Divider(height: 24, thickness: 2),
            _buildResultFila('Propietario', p.nombrePropietario),
            _buildResultFila('Edad', '${p.edadPropietario} años'),
            _buildResultFila('Modelo', p.modeloAuto),
            _buildResultFila('Valor Auto', '\$${p.valorAuto.toStringAsFixed(2)}'),
            _buildResultFila('Accidentes', '${p.numeroAccidentes}'),
            const Divider(height: 24, thickness: 2),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.lightGreen, AppTheme.primaryGreen],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.white, size: 28),
                      SizedBox(width: 8),
                      Text(
                        'COSTO TOTAL:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${p.costoTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultFila(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(valor, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
