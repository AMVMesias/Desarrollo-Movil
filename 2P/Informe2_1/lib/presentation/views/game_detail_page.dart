import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/game.dart';

class GameDetailPage extends StatefulWidget {
  final GameEntity game;

  const GameDetailPage({Key? key, required this.game}) : super(key: key);

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  int _likeCount = 0;
  int _mehCount = 0;
  int _dislikeCount = 0;
  String? _userReaction;
  bool _isInLibrary = false;

  @override
  void initState() {
    super.initState();
    // Simular valores aleatorios de ratings
    _likeCount = 12 + (widget.game.id % 50);
    _mehCount = (widget.game.id % 10);
    _dislikeCount = (widget.game.id % 5);
  }

  void _setReaction(String reaction) {
    setState(() {
      // Remover reacción anterior
      if (_userReaction == 'like') _likeCount--;
      if (_userReaction == 'meh') _mehCount--;
      if (_userReaction == 'dislike') _dislikeCount--;

      // Agregar nueva reacción
      if (_userReaction == reaction) {
        _userReaction = null; // Toggle off
      } else {
        _userReaction = reaction;
        if (reaction == 'like') _likeCount++;
        if (reaction == 'meh') _mehCount++;
        if (reaction == 'dislike') _dislikeCount++;
      }
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo abrir: $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalRatings = _likeCount + _mehCount + _dislikeCount;
    final membersInLibrary = 204 + (widget.game.id % 500);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con imagen de fondo estilo FreeToGame
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.game.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen completa sin recortar
                  Container(
                    color: Colors.black,
                    child: Hero(
                      tag: 'game-${widget.game.id}',
                      child: Center(
                        child: Image.network(
                          widget.game.thumbnail,
                          fit: BoxFit.contain, // Muestra la imagen completa
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  // Gradiente oscuro
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  // Badge FREE estilo FreeToGame
                  Positioned(
                    top: 60,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF2C3E50),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                
                // Botón PLAY NOW destacado estilo FreeToGame
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () => _launchURL(widget.game.gameUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PLAY NOW',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.play_circle_outline, size: 20),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Botones de reacción estilo FreeToGame mejorados
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildReactionButton(
                          icon: Icons.thumb_up_outlined,
                          selectedIcon: Icons.thumb_up,
                          label: 'LIKE',
                          count: _likeCount,
                          color: Color(0xFF4CAF50),
                          isSelected: _userReaction == 'like',
                          onTap: () => _setReaction('like'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildReactionButton(
                          icon: Icons.horizontal_rule,
                          selectedIcon: Icons.horizontal_rule,
                          label: 'MEH',
                          count: _mehCount,
                          color: Color(0xFF9E9E9E),
                          isSelected: _userReaction == 'meh',
                          onTap: () => _setReaction('meh'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildReactionButton(
                          icon: Icons.thumb_down_outlined,
                          selectedIcon: Icons.thumb_down,
                          label: 'DISLIKE',
                          count: _dislikeCount,
                          color: Color(0xFFF44336),
                          isSelected: _userReaction == 'dislike',
                          onTap: () => _setReaction('dislike'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildReactionButton(
                          icon: Icons.add_circle_outline,
                          selectedIcon: Icons.add_circle,
                          label: 'ADD',
                          count: null,
                          color: Color(0xFF2196F3),
                          isSelected: _isInLibrary,
                          onTap: () {
                            setState(() => _isInLibrary = !_isInLibrary);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_isInLibrary ? '✅ Added to library' : '❌ Removed from library'),
                                duration: Duration(seconds: 1),
                                backgroundColor: _isInLibrary ? Colors.green : Colors.red,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                Divider(height: 40, thickness: 1, indent: 16, endIndent: 16),
                
                // Navegación breadcrumb estilo FreeToGame
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(' > ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                        'Free Games',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(' > ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Expanded(
                        child: Text(
                          widget.game.title,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Título del juego
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.game.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Rating general estilo FreeToGame
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFFFD700), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Very Positive',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$totalRatings Member Ratings',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.people, color: Colors.grey, size: 18),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '$membersInLibrary Members have this game in their library!',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Información del juego en cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Game Information',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildInfoRow(context, Icons.category, 'Genre', widget.game.genre),
                          Divider(height: 24),
                          _buildInfoRow(context, Icons.devices, 'Platform', widget.game.platform),
                          Divider(height: 24),
                          _buildInfoRow(context, Icons.business, 'Publisher', widget.game.publisher),
                          Divider(height: 24),
                          _buildInfoRow(context, Icons.code, 'Developer', widget.game.developer),
                          Divider(height: 24),
                          _buildInfoRow(context, Icons.calendar_today, 'Release Date', widget.game.releaseDate),
                        ],
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Descripción
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '📖 About ${widget.game.title}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          widget.game.shortDescription,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Botón adicional "More Info"
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton.icon(
                    onPressed: () => _launchURL(widget.game.freetogameProfileUrl),
                    icon: Icon(Icons.info_outline),
                    label: Text('View on FreeToGame'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(double.infinity, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int? count,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.15) : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.grey.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected ? color : Colors.grey.shade400,
                size: 28,
              ),
              SizedBox(height: 6),
              if (count != null)
                Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? color : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : Colors.grey.shade400,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
