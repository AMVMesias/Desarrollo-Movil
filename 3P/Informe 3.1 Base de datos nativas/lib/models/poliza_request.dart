// ============================================================================
// MODEL - POLIZA REQUEST (MVC)
// ============================================================================
// Representa los datos que se envían al backend
// ============================================================================

class PolizaRequest {
  final String nombrePropietario;
  final int edadPropietario;
  final double valorAuto;
  final String modeloAuto;
  final int numeroAccidentes;
  final double costoTotal;

  PolizaRequest({
    required this.nombrePropietario,
    required this.edadPropietario,
    required this.valorAuto,
    required this.modeloAuto,
    required this.numeroAccidentes,
    required this.costoTotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'propietario': nombrePropietario,
      'edadPropietario': edadPropietario,
      'valorSeguroAuto': valorAuto,
      'modeloAuto': modeloAuto,
      'accidentes': numeroAccidentes,
    };
  }
}
