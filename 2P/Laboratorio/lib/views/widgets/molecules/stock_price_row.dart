import 'package:flutter/material.dart';
import '../../../models/stock.dart';
import '../../../themes/color_scheme.dart';
import '../atoms/stock_icon.dart';
import '../atoms/price_text.dart';
import '../atoms/change_indicator.dart';

/// Molecule: Complete stock price row
/// Combines StockIcon, PriceText and ChangeIndicator
class StockPriceRow extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;
  final bool showDetails;

  const StockPriceRow({
    super.key,
    required this.stock,
    this.onTap,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Stock icon with logo
            StockIcon(
              symbol: stock.symbol,
              logoUrl: stock.logoUrl,
            ),
            const SizedBox(width: 16),
            
            // Stock info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stock.name,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Price and change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PriceText(
                  price: stock.currentPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                ChangeIndicator(
                  change: stock.change,
                  changePercent: stock.changePercent,
                  showPercent: false,
                  compact: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
