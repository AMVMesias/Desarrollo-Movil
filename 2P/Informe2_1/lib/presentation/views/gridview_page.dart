import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../viewmodels/game_viewmodel.dart';
import '../../domain/entities/game.dart';

class GridViewPage extends StatefulWidget {
  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Aquí se podría cargar más datos (infinite scroll)
      print("Reached the end of the grid");
    }
  }

  void _showFilterDialog(BuildContext context, GameViewModel vm) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🎮 Filtros',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    vm.clearFilters();
                    Navigator.pop(context);
                  },
                  child: Text('Limpiar'),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Filtro de Género
            Text('Género', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: vm.genres.map((genre) {
                final isSelected = vm.selectedGenre == genre;
                return FilterChip(
                  label: Text(genre),
                  selected: isSelected,
                  onSelected: (selected) {
                    vm.setGenreFilter(selected ? genre : null);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            
            // Filtro de Plataforma
            Text('Plataforma', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: vm.platforms.map((platform) {
                final isSelected = vm.selectedPlatform == platform;
                return FilterChip(
                  label: Text(platform),
                  selected: isSelected,
                  onSelected: (selected) {
                    vm.setPlatformFilter(selected ? platform : null);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("🎮 "),
            Text("Free-To-Play Games"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, vm),
          ),
        ],
      ),
      body: vm.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error: ${vm.error}', textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => vm.loadData(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            )
          : vm.loading
              ? _buildLottieLoading()
              : Column(
                  children: [
                    // Barra de búsqueda
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: '🔍 Buscar juegos...',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    vm.setSearchQuery('');
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        ),
                        onChanged: (value) => vm.setSearchQuery(value),
                      ),
                    ),
                    
                    // Filtros rápidos de géneros populares
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildQuickFilterChip(context, vm, '🎮 MMORPG', 'MMORPG'),
                          _buildQuickFilterChip(context, vm, '⚔️ Shooter', 'Shooter'),
                          _buildQuickFilterChip(context, vm, '🎯 MOBA', 'MOBA'),
                          _buildQuickFilterChip(context, vm, '🎲 Battle Royale', 'Battle Royale'),
                          _buildQuickFilterChip(context, vm, '🧩 Strategy', 'Strategy'),
                          _buildQuickFilterChip(context, vm, '🏎️ Racing', 'Racing'),
                          _buildQuickFilterChip(context, vm, '🃏 Card Game', 'Card Game'),
                          _buildQuickFilterChip(context, vm, '⚽ Sports', 'Sports'),
                          _buildQuickFilterChip(context, vm, '🎪 Fighting', 'Fighting'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Filtros activos
                    if (vm.selectedGenre != null || vm.selectedPlatform != null)
                      Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            if (vm.selectedGenre != null)
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Chip(
                                  label: Text(vm.selectedGenre!),
                                  deleteIcon: Icon(Icons.close, size: 16),
                                  onDeleted: () => vm.setGenreFilter(null),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            if (vm.selectedPlatform != null)
                              Chip(
                                label: Text(vm.selectedPlatform!),
                                deleteIcon: Icon(Icons.close, size: 16),
                                onDeleted: () => vm.setPlatformFilter(null),
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                              ),
                          ],
                        ),
                      ),
                    
                    // Contador de resultados
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            '${vm.items.length} juegos encontrados',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Grid
                    Expanded(
                      child: vm.items.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off, size: 60, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text('No se encontraron juegos'),
                                ],
                              ),
                            )
                          : GridView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.all(8),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: vm.items.length,
                              itemBuilder: (_, i) {
                                final GameEntity game = vm.items[i];

                                return Card(
                                  elevation: 4,
                                  color: Theme.of(context).colorScheme.secondary,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/game-detail',
                                        arguments: game,
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag: 'game-${game.id}',
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                                  child: Image.network(
                                                    game.thumbnail,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Text(
                                                    'FREE',
                                                    style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  game.title,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Icon(Icons.category, size: 12, color: Colors.grey),
                                                    SizedBox(width: 4),
                                                    Expanded(
                                                      child: Text(
                                                        game.genre,
                                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildQuickFilterChip(BuildContext context, GameViewModel vm, String label, String genre) {
    final isSelected = vm.selectedGenre == genre;
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          vm.setGenreFilter(selected ? genre : null);
        },
        selectedColor: Theme.of(context).colorScheme.primary,
        checkmarkColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        elevation: isSelected ? 4 : 1,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }

  Widget _buildLottieLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://lottie.host/b4bc5f3d-65cd-4a62-bde1-e6f39c7b7a87/hNpGgx0FZy.json',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          Text(
            '🎮 Cargando juegos increíbles...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
