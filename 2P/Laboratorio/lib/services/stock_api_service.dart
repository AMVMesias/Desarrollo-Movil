import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controllers/constants/api_constants.dart';
import '../models/stock.dart';

/// Service for fetching stock data from Finnhub API
class StockApiService {
  final http.Client _client;

  StockApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Get quote for a specific stock
  Future<Stock?> getQuote(String symbol, String name) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.quoteEndpoint}'
        '?symbol=$symbol&token=${ApiConstants.apiKey}',
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Verify valid data
        if (data['c'] != null && data['c'] != 0) {
          // Get company logo
          final logoUrl = await getCompanyLogo(symbol);
          return Stock.fromFinnhub(data, symbol, name, logoUrl: logoUrl);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching quote for $symbol: $e');
      return null;
    }
  }

  /// Get company logo URL from profile endpoint
  Future<String?> getCompanyLogo(String symbol) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.profileEndpoint}'
        '?symbol=$symbol&token=${ApiConstants.apiKey}',
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['logo'] as String?;
      }
      return null;
    } catch (e) {
      print('Error fetching logo for $symbol: $e');
      return null;
    }
  }

  /// Get quotes for multiple stocks
  Future<List<Stock>> getMultipleQuotes(List<Map<String, String>> stocks) async {
    final List<Stock> results = [];
    
    for (final stock in stocks) {
      final quote = await getQuote(stock['symbol']!, stock['name']!);
      if (quote != null) {
        results.add(quote);
      }
      // Small pause to avoid rate limiting
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    return results;
  }

  /// Get mock data for demonstration (when no API key)
  List<Stock> getMockStocks() {
    return [
      Stock.mock('AAPL', 'Apple Inc.', 178.50, 2.35, 
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/AAPL.png'),
      Stock.mock('GOOGL', 'Alphabet Inc.', 141.25, -1.50,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/GOOGL.png'),
      Stock.mock('MSFT', 'Microsoft Corp.', 378.90, 4.20,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/MSFT.png'),
      Stock.mock('AMZN', 'Amazon.com Inc.', 153.40, 0.85,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/AMZN.png'),
      Stock.mock('TSLA', 'Tesla Inc.', 248.75, -5.60,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/TSLA.png'),
      Stock.mock('META', 'Meta Platforms', 505.20, 8.15,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/META.png'),
      Stock.mock('NVDA', 'NVIDIA Corp.', 475.30, 12.40,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/NVDA.png'),
      Stock.mock('JPM', 'JPMorgan Chase', 195.60, 1.20,
          logoUrl: 'https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/JPM.png'),
    ];
  }

  void dispose() {
    _client.close();
  }
}
