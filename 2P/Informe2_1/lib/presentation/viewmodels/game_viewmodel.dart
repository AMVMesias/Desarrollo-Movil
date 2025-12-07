import '../../domain/entities/game.dart';
import '../../domain/usecases/get_data_usecase.dart';
import 'base_viewmodel.dart';

class GameViewModel extends BaseViewModel<GameEntity> {
  GameViewModel(GetDataUseCase<GameEntity> useCase) : super(useCase);

  List<GameEntity> _allGames = [];
  String _searchQuery = '';
  String? _selectedGenre;
  String? _selectedPlatform;

  String get searchQuery => _searchQuery;
  String? get selectedGenre => _selectedGenre;
  String? get selectedPlatform => _selectedPlatform;

  // Obtener lista única de géneros
  List<String> get genres {
    final genreSet = <String>{};
    for (var game in _allGames) {
      genreSet.add(game.genre);
    }
    final list = genreSet.toList()..sort();
    return list;
  }

  // Obtener lista única de plataformas
  List<String> get platforms {
    final platformSet = <String>{};
    for (var game in _allGames) {
      // Separar plataformas múltiples (ejemplo: "PC (Windows), Web Browser")
      final parts = game.platform.split(',');
      for (var part in parts) {
        platformSet.add(part.trim());
      }
    }
    final list = platformSet.toList()..sort();
    return list;
  }

  @override
  Future<void> loadData() async {
    loading = true;
    notifyListeners();

    try {
      print('🔄 Loading data...');
      _allGames = await useCase();
      print('✅ Data loaded: ${_allGames.length} items');
      _applyFilters();
    } catch (e) {
      error = e.toString();
      print('❌ Error loading data: $error');
    }

    loading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setGenreFilter(String? genre) {
    _selectedGenre = genre;
    _applyFilters();
  }

  void setPlatformFilter(String? platform) {
    _selectedPlatform = platform;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedGenre = null;
    _selectedPlatform = null;
    _applyFilters();
  }

  void _applyFilters() {
    items = _allGames.where((game) {
      // Filtro de búsqueda
      final matchesSearch = _searchQuery.isEmpty ||
          game.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          game.genre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          game.developer.toLowerCase().contains(_searchQuery.toLowerCase());

      // Filtro de género
      final matchesGenre = _selectedGenre == null || game.genre == _selectedGenre;

      // Filtro de plataforma
      final matchesPlatform = _selectedPlatform == null || 
          game.platform.contains(_selectedPlatform!);

      return matchesSearch && matchesGenre && matchesPlatform;
    }).toList();

    notifyListeners();
  }
}
