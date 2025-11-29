import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/character_viewmodel.dart';
import '../themes/app_theme.dart';
import '../widgets/molecules/family_filter.dart';
import '../widgets/molecules/pagination_controls.dart';
import '../widgets/organisms/character_list_organism.dart';

/// PAGE/TEMPLATE: Página principal que combina todos los organismos
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(context, viewModel),
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Lista de personajes (Organism)
                  Expanded(
                    child: CharacterListOrganism(
                      isLoading: viewModel.loading,
                      characters: viewModel.characters,
                      onCharacterTap: (character) {
                        _showCharacterDetail(context, character);
                      },
                    ),
                  ),
                  // Controles de paginación (Molecule)
                  PaginationControls(
                    currentPage: viewModel.currentPage,
                    totalPages: viewModel.totalPages,
                    hasPrevious: viewModel.hasPreviousPage,
                    hasNext: viewModel.hasNextPage,
                    onPrevious: viewModel.previousPage,
                    onNext: viewModel.nextPage,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, CharacterViewModel viewModel) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryColor.withOpacity(0.8),
            ],
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.castle,
              size: 24,
              color: AppTheme.goldColor,
            ),
          ),
          const SizedBox(width: 10),
          const Text('Game of Thrones'),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: FamilyFilter(
            selectedFamily: viewModel.selectedFamily,
            families: viewModel.families,
            onFamilyChanged: viewModel.filterByFamily,
          ),
        ),
      ),
    );
  }

  void _showCharacterDetail(BuildContext context, character) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Imagen grande
                    Hero(
                      tag: 'character_${character.id}',
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.goldColor,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.goldColor.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(character.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Nombre
                    Text(
                      character.fullName,
                      style: AppTheme.headingLarge.copyWith(
                        color: AppTheme.goldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Título
                    if (character.title.isNotEmpty)
                      Text(
                        character.title,
                        style: AppTheme.bodyMedium.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 24),
                    // Información adicional
                    _buildInfoRow(Icons.shield, 'Casa', character.family),
                    _buildInfoRow(Icons.person, 'Nombre', character.firstName),
                    _buildInfoRow(Icons.badge, 'Apellido', character.lastName),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.3),
        borderRadius: AppTheme.smallRadius,
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.goldColor, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.caption,
              ),
              Text(
                value,
                style: AppTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
