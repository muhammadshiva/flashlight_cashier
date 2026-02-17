import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/product_bloc.dart';
import '../product_form_dialog.dart';

class ProductStatsAndFilter extends StatelessWidget {
  const ProductStatsAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              'Products',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            const Spacer(),
            _buildSearchField(context),
            SizedBox(width: 16.w),
            _buildAddButton(context),
          ],
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.slate400, size: 20.w),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProductsEvent(value));
              },
              decoration: InputDecoration(
                hintText: 'Search product name, sku... (min 3 chars)',
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(color: AppColors.slate400, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final result = await ProductFormDialog.show(context);
        if (result == true && context.mounted) {
          context.read<ProductBloc>().add(LoadProducts());
        }
      },
      icon: const Icon(Icons.add, size: 14),
      label: const Text('Add Product'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orangePrimary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
      ),
    );
  }
}
