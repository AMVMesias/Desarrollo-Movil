import 'package:flutter/material.dart';
import '../view/calculate_increase_screen.dart';
import '../view/history_screen.dart';
import '../view/home_page.dart';
import '../view/pdf_report_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String calculateIncrease = '/calculate';
  static const String history = '/history';
  static const String pdfReport = '/pdf_report';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    calculateIncrease: (context) => const CalculateIncreaseScreen(),
    history: (context) => const HistoryScreen(),
    pdfReport: (context) => const PdfReportScreen(),
  };
}
