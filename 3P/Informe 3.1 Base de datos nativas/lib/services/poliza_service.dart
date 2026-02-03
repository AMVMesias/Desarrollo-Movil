import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/poliza_request.dart';
import '../models/poliza_response.dart';

// ============================================================================
// SERVICE - COMUNICACIÓN CON API REST (MVC)
// ============================================================================
// Solo se encarga de comunicarse con el backend
// NO calcula nada, NO tiene lógica de negocio
// Solo envía y recibe datos del servidor
// ============================================================================

class PolizaService {
  static const String baseUrl = 'http://10.0.2.2:9090/bdd_dto/api/poliza';

  /// Guarda póliza en el backend
  Future<PolizaResponse> guardarPoliza(PolizaRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return PolizaResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error al guardar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Obtiene póliza por nombre
  Future<PolizaResponse> obtenerPolizaPorNombre(String nombre) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/usuario?nombre=$nombre'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return PolizaResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('No encontrado');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
