import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/views/main_page.dart';
import 'presentation/temas/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contactos DDD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainPage(),
    );
  }
}
