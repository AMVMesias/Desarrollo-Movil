import 'package:flutter/material.dart';
import '../../../models/stock.dart';
import '../molecules/stock_price_row.dart';

/// Organism: Scrollable stock list
/// Shows all available stocks
class StockList extends StatelessWidget {
  final List<Stock> stocks;
  final Function(Stock)? onStockTap;
  final bool shrinkWrap;

  const StockList({
    super.key,
    required this.stocks,
    this.onStockTap,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No stocks available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap 
          ? const NeverScrollableScrollPhysics() 
          : const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: stocks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return StockPriceRow(
          stock: stock,
          onTap: onStockTap != null ? () => onStockTap!(stock) : null,
        );
      },
    );
  }
}
