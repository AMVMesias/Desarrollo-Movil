import 'package:flutter/foundation.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../data/models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final CharacterRepositoryImpl repository;

  bool loading = false;
  List<CharacterModel> _allCharacters = [];
  List<CharacterModel> _filteredCharacters = [];
  
  // Paginación
  static const int itemsPerPage = 10;
  int _currentPage = 0;
  
  // Filtro por familia
  String? _selectedFamily;
  List<String> _families = [];

  CharacterViewModel(this.repository);

  // Getters
  List<CharacterModel> get characters => _paginatedCharacters;
  List<CharacterModel> get _paginatedCharacters {
    final start = _currentPage * itemsPerPage;
    final end = start + itemsPerPage;
    if (start >= _filteredCharacters.length) return [];
    return _filteredCharacters.sublist(
      start, 
      end > _filteredCharacters.length ? _filteredCharacters.length : end
    );
  }
  
  int get currentPage => _currentPage;
  int get totalPages => (_filteredCharacters.length / itemsPerPage).ceil();
  bool get hasNextPage => _currentPage < totalPages - 1;
  bool get hasPreviousPage => _currentPage > 0;
  
  String? get selectedFamily => _selectedFamily;
  List<String> get families => _families;

  Future<void> loadCharacters() async {
    loading = true;
    notifyListeners();
    try {
      _allCharacters = await repository.getAllCharacters();
      _filteredCharacters = _allCharacters;
      _extractFamilies();
      _currentPage = 0;
    } catch (e) {
      _allCharacters = [];
      _filteredCharacters = [];
    }
    loading = false;
    notifyListeners();
  }

  void _extractFamilies() {
    final familySet = <String>{};
    for (var character in _allCharacters) {
      if (character.family.isNotEmpty) {
        familySet.add(character.family);
      }
    }
    _families = familySet.toList()..sort();
  }

  void filterByFamily(String? family) {
    _selectedFamily = family;
    _currentPage = 0;
    
    if (family == null || family.isEmpty) {
      _filteredCharacters = _allCharacters;
    } else {
      _filteredCharacters = _allCharacters
          .where((c) => c.family == family)
          .toList();
    }
    notifyListeners();
  }

  void nextPage() {
    if (hasNextPage) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (hasPreviousPage) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }
}

