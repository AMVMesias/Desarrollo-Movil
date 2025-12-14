/// Stock quote model
/// Represents data for an individual stock
class Stock {
  final String symbol;          // Stock symbol (AAPL, GOOGL)
  final String name;            // Company name
  final String? logoUrl;        // Company logo URL from API
  final double currentPrice;    // Current price
  final double change;          // Absolute change
  final double changePercent;   // Percent change
  final double high;            // Day's high
  final double low;             // Day's low
  final double open;            // Opening price
  final double previousClose;   // Previous close
  final DateTime timestamp;     // Last update

  Stock({
    required this.symbol,
    required this.name,
    this.logoUrl,
    required this.currentPrice,
    required this.change,
    required this.changePercent,
    required this.high,
    required this.low,
    required this.open,
    required this.previousClose,
    required this.timestamp,
  });

  /// Indicates if stock is gaining
  bool get isGaining => change > 0;

  /// Indicates if stock is losing
  bool get isLosing => change < 0;

  /// Factory to create from Finnhub API response
  factory Stock.fromFinnhub(
    Map<String, dynamic> quote, 
    String symbol, 
    String name, 
    {String? logoUrl}
  ) {
    return Stock(
      symbol: symbol,
      name: name,
      logoUrl: logoUrl,
      currentPrice: (quote['c'] ?? 0).toDouble(),      // Current price
      change: (quote['d'] ?? 0).toDouble(),            // Change
      changePercent: (quote['dp'] ?? 0).toDouble(),    // Percent change
      high: (quote['h'] ?? 0).toDouble(),              // High price of the day
      low: (quote['l'] ?? 0).toDouble(),               // Low price of the day
      open: (quote['o'] ?? 0).toDouble(),              // Open price
      previousClose: (quote['pc'] ?? 0).toDouble(),    // Previous close
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        ((quote['t'] ?? 0) * 1000).toInt(),
      ),
    );
  }

  /// Create mock/test stock
  factory Stock.mock(String symbol, String name, double price, double change, {String? logoUrl}) {
    return Stock(
      symbol: symbol,
      name: name,
      logoUrl: logoUrl,
      currentPrice: price,
      change: change,
      changePercent: (change / price) * 100,
      high: price + 5,
      low: price - 3,
      open: price - change,
      previousClose: price - change,
      timestamp: DateTime.now(),
    );
  }

  /// Serialize for native widget
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'logoUrl': logoUrl,
      'currentPrice': currentPrice,
      'change': change,
      'changePercent': changePercent,
      'isGaining': isGaining,
    };
  }

  /// Create copy with new values
  Stock copyWith({
    String? symbol,
    String? name,
    String? logoUrl,
    double? currentPrice,
    double? change,
    double? changePercent,
    double? high,
    double? low,
    double? open,
    double? previousClose,
    DateTime? timestamp,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      currentPrice: currentPrice ?? this.currentPrice,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      high: high ?? this.high,
      low: low ?? this.low,
      open: open ?? this.open,
      previousClose: previousClose ?? this.previousClose,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
