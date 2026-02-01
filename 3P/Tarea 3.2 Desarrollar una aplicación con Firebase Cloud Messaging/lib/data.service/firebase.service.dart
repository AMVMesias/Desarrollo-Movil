import 'package:firebase_database/firebase_database.dart';
import '../../domain.models/mensaje.dart';

class FirebaseDataService {
  // ruta a la base de datos
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('chat/general');


  Future<void> enviarMensaje(Mensaje mensaje) async {
    await _ref.push().set(mensaje.toJson());
  }


  // metodo para recibir mensajes en tiempo real
  Stream<List<Mensaje>> recibirMensaje() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];
        return data.values
          .map((e) => Mensaje.fromJson(e))
          .toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    });
  }

  // getter para acceder a la referencia desde la app
 // DatabaseReference get referencia => _ref;

  // getter para mensajes (alias)
  //DatabaseReference get mensajesRef => _ref;

  // Stream para escuchar mensajes en tiempo real
  //Stream<DatabaseEvent> get mensajesStream => _ref.onValue;
}
