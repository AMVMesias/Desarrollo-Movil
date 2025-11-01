import '../models/classroom.dart';

// Ejercicio 4.10
class SchoolController {
  List<Classroom> classrooms = [];

  void addClassroom(Classroom classroom) {
    classrooms.add(classroom);
  }

  void clearData() {
    classrooms.clear();
  }

  double get overallAverageAge {
    final allStudents = classrooms.expand((c) => c.students).toList();

    if (allStudents.isEmpty) {
      return 0; // Valida: si no hay estudiantes retorna 0
    }

    final totalAge = allStudents.map((s) => s.age).reduce((a, b) => a + b);
    return totalAge / allStudents.length;
  }
}
