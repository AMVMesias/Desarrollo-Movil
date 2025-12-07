import 'package:flutter/material.dart';
import '../views/home_page.dart';
import '../views/game_detail_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => HomePage(),
  };
  
  static const String gameDetail = '/game-detail';
}
