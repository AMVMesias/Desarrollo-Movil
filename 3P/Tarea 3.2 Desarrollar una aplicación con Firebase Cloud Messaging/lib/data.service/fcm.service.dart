import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Manejador de mensajes en background (debe ser función top-level)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📩 Mensaje en background: ${message.notification?.title}');
}

/// Servicio para manejar Firebase Cloud Messaging
class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? _token;

  /// Token FCM del dispositivo (para enviar notificaciones específicas)
  String? get token => _token;

  /// Inicializa FCM y solicita permisos
  Future<void> initialize() async {
    // Registrar el handler de background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Solicitar permisos (iOS principalmente)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('✅ Permisos de notificación concedidos');
    } else {
      debugPrint('❌ Permisos de notificación denegados');
    }

    // Obtener el token FCM
    _token = await _messaging.getToken();
    debugPrint('🔑 Token FCM: $_token');

    // Escuchar cambios de token
    _messaging.onTokenRefresh.listen((newToken) {
      _token = newToken;
      debugPrint('🔄 Token FCM actualizado: $newToken');
    });

    // Escuchar mensajes en foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📬 Mensaje en foreground: ${message.notification?.title}');
      debugPrint('   Body: ${message.notification?.body}');
      debugPrint('   Data: ${message.data}');
    });

    // Escuchar cuando el usuario toca una notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('👆 Usuario abrió notificación: ${message.notification?.title}');
    });
  }

  /// Suscribirse a un tema (para notificaciones grupales)
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    debugPrint('📢 Suscrito al tema: $topic');
  }

  /// Desuscribirse de un tema
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    debugPrint('🔕 Desuscrito del tema: $topic');
  }
}
