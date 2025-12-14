import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_widget/home_widget.dart';
import 'controllers/stock_controller.dart';
import 'controllers/theme_controller.dart';
import 'themes/general_theme.dart';
import 'views/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure home widget
  HomeWidget.setAppGroupId('group.stockwidget');
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StockController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: const StockWidgetApp(),
    ),
  );
}

class StockWidgetApp extends StatefulWidget {
  const StockWidgetApp({super.key});

  @override
  State<StockWidgetApp> createState() => _StockWidgetAppState();
}

class _StockWidgetAppState extends State<StockWidgetApp> {
  @override
  void initState() {
    super.initState();
    _checkLaunchedFromWidget();
    // Load data on init to update widget
    Future.microtask(() {
      Provider.of<StockController>(context, listen: false).loadStocks();
    });
  }
  
  /// Detect if app was launched from widget
  Future<void> _checkLaunchedFromWidget() async {
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (uri != null) {
      debugPrint('App launched from widget with uri: $uri');
    }

    // Listen for widget clicks
    HomeWidget.widgetClicked.listen((uri) {
      if (uri != null) {
        debugPrint('Widget clicked with uri: $uri');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, _) {
        return MaterialApp(
          title: 'Stock Widget',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeController.themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}
