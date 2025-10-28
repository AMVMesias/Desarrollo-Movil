import '../model/empleado_model.dart';

class EmpleadoController {
  String calcularSueldo(String edadTexto, String antiguedadTexto) {
    // Validación de campos vacíos
    if (edadTexto.isEmpty || antiguedadTexto.isEmpty) {
      return "Llene todos los campos";
    }

    final edad = int.tryParse(edadTexto);
    final antiguedad = int.tryParse(antiguedadTexto);

    // Validación de valores numéricos
    if (edad == null || antiguedad == null) {
      return "Ingrese valores numéricos enteros";
    }

    // Validación de valores positivos
    if (edad <= 0 || antiguedad < 0) {
      return "La edad debe ser mayor a 0 y la antigüedad no puede ser negativa";
    }

    // Validación de rango de edad razonable
    if (edad < 18) {
      return "La edad debe ser mayor o igual a 18 años";
    }

    if (edad > 100) {
      return "Ingrese una edad válida (menor a 100 años)";
    }

    // Validación de antigüedad razonable
    if (antiguedad > edad - 18) {
      return "La antigüedad no puede ser mayor que la edad laboral del empleado";
    }

    // Cálculo del sueldo
    final empleado = EmpleadoModel(edad, antiguedad);
    final sueldo = empleado.calcularSueldo();
    
    return "Sueldo semanal: \$${sueldo.toStringAsFixed(0)}";
  }
}
