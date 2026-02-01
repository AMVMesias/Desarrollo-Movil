import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'data.service/fcm.service.dart';
import 'presentation/views/chat_view.dart';
import 'presentation/temas/chat_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar Firebase Cloud Messaging
  await FCMService().initialize();
  // Suscribirse al tema del chat general para recibir notificaciones grupales
  await FCMService().subscribeToTopic('chat_general');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Minimalista',
      debugShowCheckedModeBanner: false,
      theme: ChatTheme.theme,
      home: ChatView(),
    );
  }
}
