import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data.service/firebase.service.dart';
import '../domain.models/mensaje.dart';

/// Provider para instancia singleton del servicio Firebase
final firebaseServiceProvider = Provider<FirebaseDataService>(
    (ref) => FirebaseDataService());

/// StreamProvider para escuchar mensajes en tiempo real
final mensajeProvider = StreamProvider<List<Mensaje>>((ref) {
  final service = ref.read(firebaseServiceProvider);
  return service.recibirMensaje();
});
