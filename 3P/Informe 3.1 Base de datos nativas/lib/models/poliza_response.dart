// ============================================================================
// MODEL - POLIZA RESPONSE (MVC)
// ============================================================================
// Representa los datos de una póliza calculada
// ============================================================================

class PolizaResponse {
  final String nombrePropietario;
  final String modeloAuto;
  final double valorAuto;
  final int edadPropietario;
  final int numeroAccidentes;
  final double costoTotal;

  PolizaResponse({
    required this.nombrePropietario,
    required this.modeloAuto,
    required this.valorAuto,
    required this.edadPropietario,
    required this.numeroAccidentes,
    required this.costoTotal,
  });

  factory PolizaResponse.fromJson(Map<String, dynamic> json) {
    return PolizaResponse(
      nombrePropietario: json['propietario'] ?? '',
      modeloAuto: json['modeloAuto'] ?? '',
      valorAuto: (json['valorSeguroAuto'] ?? 0).toDouble(),
      edadPropietario: json['edadPropietario'] ?? 0,
      numeroAccidentes: json['accidentes'] ?? 0,
      costoTotal: (json['costoTotal'] ?? 0).toDouble(),
    );
  }

  factory PolizaResponse.fromLocal({
    required String nombre,
    required int edad,
    required double valor,
    required String modelo,
    required int accidentes,
    required double costo,
  }) {
    return PolizaResponse(
      nombrePropietario: nombre,
      edadPropietario: edad,
      valorAuto: valor,
      modeloAuto: modelo,
      numeroAccidentes: accidentes,
      costoTotal: costo,
    );
  }
}
