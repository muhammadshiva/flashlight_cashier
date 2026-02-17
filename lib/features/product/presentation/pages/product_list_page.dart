import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/shared/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../bloc/product_bloc.dart';
import 'components/product_pagination.dart';
import 'components/product_stats_and_filter.dart';
import 'components/product_table.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProducts()),
      child: const _ProductContentView(),
    );
  }
}

class _ProductContentView extends StatelessWidget {
  const _ProductContentView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 16.w, 32.w, 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProductStatsAndFilter(),
          SizedBox(height: 12.w),
          Expanded(child: _buildTableContainer()),
        ],
      ),
    );
  }

  Widget _buildTableContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Divider(height: 1, color: AppColors.slate100),
          Expanded(child: _buildProductContent()),
          const ProductPagination(),
        ],
      ),
    );
  }

  Widget _buildProductContent() {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProductLoading || state is ProductInitial) {
          return const CustomLoading();
        } else if (state is ProductLoaded) {
          if (state.products.isEmpty) return _buildEmptyState();
          return ProductTable(products: state.products);
        }
        return _buildEmptyState();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'Product not found',
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.slate500,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
