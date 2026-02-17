import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/product.dart';
import '../../bloc/product_bloc.dart';
import '../product_form_dialog.dart';

class ProductTable extends StatelessWidget {
  final List<Product> products;

  const ProductTable({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sticky Header
        Table(
          columnWidths: _columnWidths,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                border: const Border(
                  bottom: BorderSide(color: AppColors.slate200),
                ),
              ),
              children: const [
                _HeaderCell('PRODUCT NAME'),
                _HeaderCell('SKU'),
                _HeaderCell('PRICE'),
                _HeaderCell('STOCK'),
                _HeaderCell('STATUS'),
                _HeaderCell('ACTION', align: Alignment.centerRight),
              ],
            ),
          ],
        ),
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              columnWidths: _columnWidths,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                ...products.map((product) => _buildProductRow(context, product)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const Map<int, TableColumnWidth> _columnWidths = {
    0: FlexColumnWidth(3),
    1: FlexColumnWidth(1),
    2: FlexColumnWidth(1),
    3: FlexColumnWidth(1),
    4: FlexColumnWidth(1),
    5: FixedColumnWidth(100),
  };

  TableRow _buildProductRow(BuildContext context, Product product) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.slate100)),
      ),
      children: [
        _buildProductNameCell(product),
        _DataCell(
            text: product.id.length >= 8
                ? product.id.substring(0, 8).toUpperCase()
                : product.id.toUpperCase()),
        _DataCell(text: 'Rp ${product.price}'),
        _DataCell(text: product.stock.toString()),
        _buildStatusCell(product),
        _buildActionCell(context, product),
      ],
    );
  }

  TableCell _buildProductNameCell(Product product) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(8.r),
                image: product.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: product.imageUrl.isEmpty
                  ? Icon(Icons.image_not_supported, color: AppColors.slate400, size: 20.w)
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    product.type,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.slate500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableCell _buildStatusCell(Product product) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
        decoration: BoxDecoration(
          color: product.isAvailable ? const Color(0xFFDCFCE7) : AppColors.slate100,
          borderRadius: BorderRadius.circular(99.r),
        ),
        child: Text(
          product.isAvailable ? 'Active' : 'Inactive',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: product.isAvailable ? const Color(0xFF166534) : AppColors.slate500,
          ),
        ),
      ),
    );
  }

  TableCell _buildActionCell(BuildContext context, Product product) {
    return TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.slate500),
            onPressed: () async {
              final result = await ProductFormDialog.show(context, product: product);
              if (result == true && context.mounted) {
                context.read<ProductBloc>().add(LoadProducts());
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFFEF4444)),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  title: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: const Color(0xFFEF4444), size: 24.w),
                      SizedBox(width: 12.w),
                      Text('Delete Product',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  content: Text(
                    'Are you sure you want to delete "${product.name}"? This action cannot be undone.',
                    style: TextStyle(fontSize: 14.sp, color: const Color(0xFF475569)),
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        side: const BorderSide(color: Color(0xFFEF4444)),
                      ),
                      child: const Text('Delete',
                          style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w600)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangePrimary,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                context.read<ProductBloc>().add(DeleteProductEvent(product.id));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final Alignment align;

  const _HeaderCell(this.label, {this.align = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.slate500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;

  const _DataCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}
