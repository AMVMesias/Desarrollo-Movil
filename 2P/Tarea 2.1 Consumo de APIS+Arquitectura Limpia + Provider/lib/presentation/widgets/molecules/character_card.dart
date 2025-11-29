import 'package:flutter/material.dart' hide Badge;
import '../../../data/models/character_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/family_colors.dart';
import '../atoms/custom_avatar.dart';
import '../atoms/badge.dart';

/// MOLECULE: Tarjeta de personaje con diseño elegante
class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final VoidCallback? onTap;

  const CharacterCard({
    super.key,
    required this.character,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: AppTheme.mediumRadius,
        boxShadow: AppTheme.cardShadow,
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppTheme.mediumRadius,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar con borde dorado
                Hero(
                  tag: 'character_${character.id}',
                  child: CustomAvatar(
                    imageUrl: character.imageUrl,
                    size: 70,
                    borderWidth: 3,
                    borderColor: FamilyColors.getColorByFamily(character.family),
                  ),
                ),
                const SizedBox(width: 16),
                // Información del personaje
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre
                      Text(
                        character.fullName,
                        style: AppTheme.headingMedium.copyWith(
                          color: AppTheme.goldColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Título
                      if (character.title.isNotEmpty)
                        Text(
                          character.title,
                          style: AppTheme.bodyMedium.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 8),
                      // Badge de familia
                      if (character.family.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FamilyColors.getColorByFamily(character.family),
                                FamilyColors.getColorByFamily(character.family).withValues(alpha: 0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: FamilyColors.getColorByFamily(character.family).withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.shield, size: 12, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                character.family.length > 18
                                    ? '${character.family.substring(0, 15)}...'
                                    : character.family,
                                style: AppTheme.badge.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // Flecha decorativa
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor.withValues(alpha: 0.3),
                    borderRadius: AppTheme.smallRadius,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.goldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

