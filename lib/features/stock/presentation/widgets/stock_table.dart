import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/domain/entities/product.dart';
import '../bloc/stock_bloc.dart';
import 'stock_adjustment_dialog.dart';
import 'stock_table_cells.dart';

class StockTable extends StatelessWidget {
  final List<Product> stockItems;

  const StockTable({super.key, required this.stockItems});

  @override
  Widget build(BuildContext context) {
    // Prevent rendering if empty (should not happen due to parent check, but just in case)
    if (stockItems.isEmpty) {
      return const Center(
        child: Text(
          'No stock items found',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(3), // Product Name
          1: FlexColumnWidth(1), // SKU
          2: FlexColumnWidth(1), // Category
          3: FlexColumnWidth(1), // Current Stock
          4: FlexColumnWidth(1), // Status
          5: FixedColumnWidth(120), // Actions
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          const TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            children: [
              StockHeaderCell('PRODUCT NAME'),
              StockHeaderCell('SKU'),
              StockHeaderCell('CATEGORY'),
              StockHeaderCell('STOCK'),
              StockHeaderCell('STATUS'),
              StockHeaderCell('ACTION', align: Alignment.centerRight),
            ],
          ),
          ...stockItems.map((product) => _buildStockRow(context, product)),
        ],
      ),
    );
  }

  TableRow _buildStockRow(BuildContext context, Product product) {
    final stockStatus = _getStockStatus(product.stock);

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                    image: product.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.imageUrl.isEmpty
                      ? const Icon(Icons.image_not_supported,
                          color: Color(0xFF94A3B8), size: 20)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        StockDataCell(
          text: product.id.length >= 8
              ? product.id.substring(0, 8).toUpperCase()
              : product.id.toUpperCase(),
        ),
        StockDataCell(text: product.type),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              product.stock.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: stockStatus['color'] as Color,
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (stockStatus['bgColor'] as Color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              stockStatus['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: stockStatus['color'] as Color,
              ),
            ),
          ),
        ),
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    size: 20, color: Color(0xFF10B981)),
                onPressed: () {
                  _showAdjustStockDialog(context, product, isAddition: true);
                },
                tooltip: 'Add Stock',
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    size: 20, color: Color(0xFFEF4444)),
                onPressed: () {
                  _showAdjustStockDialog(context, product, isAddition: false);
                },
                tooltip: 'Reduce Stock',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getStockStatus(int stock) {
    if (stock == 0) {
      return {
        'label': 'Out of Stock',
        'color': const Color(0xFFEF4444),
        'bgColor': const Color(0xFFEF4444),
      };
    } else if (stock < 10) {
      return {
        'label': 'Low Stock',
        'color': const Color(0xFFF59E0B),
        'bgColor': const Color(0xFFF59E0B),
      };
    } else {
      return {
        'label': 'In Stock',
        'color': const Color(0xFF10B981),
        'bgColor': const Color(0xFF10B981),
      };
    }
  }

  void _showAdjustStockDialog(BuildContext context, Product product,
      {required bool isAddition}) {
    showDialog(
      context: context,
      builder: (dialogContext) => StockAdjustmentDialog(
        product: product,
        isAddition: isAddition,
        onAdjust: (adjustment) {
          context.read<StockBloc>().add(AdjustStockEvent(adjustment));
        },
      ),
    );
  }
}
