import 'student.dart';

// Ejercicio 4.10
class Classroom {
  String name;
  List<Student> students;

  Classroom({required this.name, required this.students});

  // Promedio = suma edades / cantidad
  double get averageAge =>
      students.map((s) => s.age).reduce((a, b) => a + b) / students.length;
}
