import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import '../models/stock.dart';
import '../services/stock_api_service.dart';
import 'constants/api_constants.dart';

/// Controller for managing stock data state
/// Uses ChangeNotifier to notify widgets of changes
class StockController extends ChangeNotifier {
  final StockApiService _apiService;
  
  List<Stock> _stocks = [];
  Stock? _featuredStock;
  int _currentWidgetIndex = 0;
  bool _isLoading = false;
  String? _error;
  bool _useMockData = false; // Using real Finnhub API

  StockController({StockApiService? apiService})
      : _apiService = apiService ?? StockApiService();

  // Getters
  List<Stock> get stocks => _stocks;
  Stock? get featuredStock => _featuredStock;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  int get currentWidgetIndex => _currentWidgetIndex;

  /// Load stocks from API or mock
  Future<void> loadStocks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_useMockData || ApiConstants.apiKey == 'demo') {
        // Use mock data
        _stocks = _apiService.getMockStocks();
      } else {
        // Use real API
        _stocks = await _apiService.getMultipleQuotes(ApiConstants.defaultStocks);
        
        // If API returns empty, use mock as fallback
        if (_stocks.isEmpty) {
          _stocks = _apiService.getMockStocks();
        }
      }
      
      // Set featured stock
      if (_stocks.isNotEmpty) {
        if (_currentWidgetIndex >= _stocks.length) {
          _currentWidgetIndex = 0;
        }
        _featuredStock = _stocks[_currentWidgetIndex];
      }

      // Update Android home widget with all stocks data
      await _updateHomeWidget();
      
    } catch (e) {
      _error = 'Error loading data: $e';
      // Fallback to mock data on error
      _stocks = _apiService.getMockStocks();
      if (_stocks.isNotEmpty) {
        _featuredStock = _stocks.first;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh a specific stock
  Future<void> refreshStock(String symbol) async {
    final stockData = ApiConstants.defaultStocks.firstWhere(
      (s) => s['symbol'] == symbol,
      orElse: () => {'symbol': symbol, 'name': symbol},
    );

    final updated = await _apiService.getQuote(
      stockData['symbol']!,
      stockData['name']!,
    );

    if (updated != null) {
      final index = _stocks.indexWhere((s) => s.symbol == symbol);
      if (index != -1) {
        _stocks[index] = updated;
        notifyListeners();
      }
    }
  }

  /// Update widget to show next stock
  Future<void> nextWidgetStock() async {
    if (_stocks.isEmpty) return;
    _currentWidgetIndex = (_currentWidgetIndex + 1) % _stocks.length;
    _featuredStock = _stocks[_currentWidgetIndex];
    await _updateHomeWidget();
    notifyListeners();
  }

  /// Update widget to show previous stock
  Future<void> previousWidgetStock() async {
    if (_stocks.isEmpty) return;
    _currentWidgetIndex = (_currentWidgetIndex - 1 + _stocks.length) % _stocks.length;
    _featuredStock = _stocks[_currentWidgetIndex];
    await _updateHomeWidget();
    notifyListeners();
  }

  /// Set widget stock by index
  Future<void> setWidgetStockIndex(int index) async {
    if (_stocks.isEmpty || index < 0 || index >= _stocks.length) return;
    _currentWidgetIndex = index;
    _featuredStock = _stocks[_currentWidgetIndex];
    await _updateHomeWidget();
    notifyListeners();
  }

  /// Update home screen widget with current stock and all stocks list
  Future<void> _updateHomeWidget() async {
    if (_featuredStock == null || _stocks.isEmpty) return;

    try {
      // Save current stock data for widget display
      await HomeWidget.saveWidgetData('stock_symbol', _featuredStock!.symbol);
      await HomeWidget.saveWidgetData('stock_name', _featuredStock!.name);
      await HomeWidget.saveWidgetData('stock_price', _featuredStock!.currentPrice.toStringAsFixed(2));
      await HomeWidget.saveWidgetData('stock_change', _featuredStock!.change.toStringAsFixed(2));
      await HomeWidget.saveWidgetData('stock_percent', _featuredStock!.changePercent.toStringAsFixed(2));
      await HomeWidget.saveWidgetData('is_gaining', _featuredStock!.isGaining);
      await HomeWidget.saveWidgetData('stock_logo_url', _featuredStock!.logoUrl ?? '');
      await HomeWidget.saveWidgetData('current_stock_index', _currentWidgetIndex);
      await HomeWidget.saveWidgetData('total_stocks', _stocks.length);

      // Save all stocks as JSON array for widget navigation
      final stocksList = _stocks.map((s) => {
        'symbol': s.symbol,
        'name': s.name,
        'price': s.currentPrice.toStringAsFixed(2),
        'change': s.change.toStringAsFixed(2),
        'percent': s.changePercent.toStringAsFixed(2),
        'isGaining': s.isGaining,
        'logoUrl': s.logoUrl ?? '',
      }).toList();
      await HomeWidget.saveWidgetData('all_stocks', jsonEncode(stocksList));

      // Update widget
      await HomeWidget.updateWidget(
        name: 'StockWidgetProvider',
        androidName: 'StockWidgetProvider',
      );
    } catch (e) {
      print('Error updating home widget: $e');
    }
  }

  /// Set featured stock for widget
  void setFeaturedStock(Stock stock) {
    final index = _stocks.indexWhere((s) => s.symbol == stock.symbol);
    if (index != -1) {
      _currentWidgetIndex = index;
    }
    _featuredStock = stock;
    _updateHomeWidget();
    notifyListeners();
  }

  /// Get stocks that are gaining
  List<Stock> get gainers => _stocks.where((s) => s.isGaining).toList();

  /// Get stocks that are losing
  List<Stock> get losers => _stocks.where((s) => s.isLosing).toList();

  /// Release resources
  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }
}
