import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/stock_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/color_scheme.dart';
import '../widgets/organisms/featured_stock_card.dart';
import '../widgets/molecules/market_stat_card.dart';
import 'stock_detail_page.dart';

/// Main page - Market dashboard
/// Shows featured stock and list of all stocks
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockController>().loadStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textColor = isDark ? AppColors.textLight : AppColors.textDark;
    
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Consumer<StockController>(
          builder: (context, controller, _) {
            if (controller.isLoading && controller.stocks.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => controller.loadStocks(),
              color: AppColors.primary,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // App Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stock Widget',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Real-time market',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Theme toggle button
                              Consumer<ThemeController>(
                                builder: (context, themeController, _) {
                                  return IconButton(
                                    icon: Icon(
                                      themeController.isDarkMode 
                                          ? Icons.light_mode 
                                          : Icons.dark_mode,
                                      color: AppColors.accent,
                                    ),
                                    onPressed: () => themeController.toggleTheme(),
                                  );
                                },
                              ),
                              // Refresh button
                              IconButton(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: AppColors.primary,
                                ),
                                onPressed: () => controller.loadStocks(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          
                          // Featured card
                          if (controller.featuredStock != null) ...[
                            FeaturedStockCard(
                              stock: controller.featuredStock!,
                              onTap: () => _openStockDetail(
                                context, 
                                controller.featuredStock!,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Stats row
                          Row(
                            children: [
                              Expanded(
                                child: MarketStatCard(
                                  title: 'Gainers',
                                  value: '${controller.gainers.length}',
                                  icon: Icons.trending_up,
                                  isPositive: true,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: MarketStatCard(
                                  title: 'Losers',
                                  value: '${controller.losers.length}',
                                  icon: Icons.trending_down,
                                  isPositive: false,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),

                          // Section title
                          Text(
                            'Popular Stocks',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Stock list
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final stock = controller.stocks[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildStockCard(context, stock, controller, isDark),
                          );
                        },
                        childCount: controller.stocks.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStockCard(BuildContext context, stock, StockController controller, bool isDark) {
    final cardColor = isDark ? AppColors.cardDark : AppColors.card;
    final textColor = isDark ? AppColors.textLight : AppColors.textDark;
    
    return InkWell(
      onTap: () => _openStockDetail(context, stock),
      onLongPress: () {
        controller.setFeaturedStock(stock);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${stock.symbol} set as widget'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primary,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark ? [] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Logo
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: stock.logoUrl != null && stock.logoUrl!.isNotEmpty
                    ? Image.network(
                        stock.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildDefaultIcon(stock),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildDefaultIcon(stock);
                        },
                      )
                    : _buildDefaultIcon(stock),
              ),
            ),
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  Text(
                    stock.name,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${stock.currentPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (stock.isGaining ? AppColors.gain : AppColors.loss)
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${stock.isGaining ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: stock.isGaining ? AppColors.gain : AppColors.loss,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIcon(stock) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
        ),
      ),
      child: Center(
        child: Text(
          stock.symbol.substring(0, 2),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _openStockDetail(BuildContext context, stock) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StockDetailPage(stock: stock),
      ),
    );
  }
}
