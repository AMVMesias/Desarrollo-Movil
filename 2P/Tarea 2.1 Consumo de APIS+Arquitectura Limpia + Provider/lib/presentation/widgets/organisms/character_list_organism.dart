import 'package:flutter/material.dart';
import '../../../data/models/character_model.dart';
import '../atoms/loading_spinner.dart';
import '../atoms/empty_state.dart';
import '../molecules/character_card.dart';

/// ORGANISM: Lista completa de personajes con estados
class CharacterListOrganism extends StatelessWidget {
  final bool isLoading;
  final List<CharacterModel> characters;
  final Function(CharacterModel)? onCharacterTap;

  const CharacterListOrganism({
    super.key,
    required this.isLoading,
    required this.characters,
    this.onCharacterTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingSpinner(
        message: 'Cargando personajes...',
      );
    }

    if (characters.isEmpty) {
      return const EmptyState(
        icon: Icons.person_search,
        title: 'No se encontraron personajes',
        subtitle: 'Intenta con otro filtro de familia',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      physics: const BouncingScrollPhysics(),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 50)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: CharacterCard(
            character: character,
            onTap: () => onCharacterTap?.call(character),
          ),
        );
      },
    );
  }
}
