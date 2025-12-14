/// API Constants for stock market services
/// Using Finnhub.io for free market data
class ApiConstants {
  // Base URL for Finnhub
  static const String baseUrl = 'https://finnhub.io/api/v1';
  
  // API Key - Finnhub free tier
  // Get your own free key at: https://finnhub.io/register
  static const String apiKey = 'YOUR_API_KEY_HERE';
  
  // Endpoints
  static const String quoteEndpoint = '/quote';
  static const String searchEndpoint = '/search';
  static const String profileEndpoint = '/stock/profile2';
  
  // Default popular stocks
  static const List<Map<String, String>> defaultStocks = [
    {'symbol': 'AAPL', 'name': 'Apple Inc.'},
    {'symbol': 'GOOGL', 'name': 'Alphabet Inc.'},
    {'symbol': 'MSFT', 'name': 'Microsoft Corp.'},
    {'symbol': 'AMZN', 'name': 'Amazon.com Inc.'},
    {'symbol': 'TSLA', 'name': 'Tesla Inc.'},
    {'symbol': 'META', 'name': 'Meta Platforms'},
    {'symbol': 'NVDA', 'name': 'NVIDIA Corp.'},
    {'symbol': 'JPM', 'name': 'JPMorgan Chase'},
  ];
  
  // Featured stock for widget
  static const String featuredStock = 'AAPL';
  
  // Refresh interval (in seconds)
  static const int refreshInterval = 60;
}
