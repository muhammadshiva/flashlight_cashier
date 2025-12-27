import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/models/pagination_actions.dart';
import '../../../../core/shared/models/pagination_config.dart';
import '../../../../core/shared/models/pagination_data.dart';
import '../../../../core/shared/models/pagination_theme.dart';
import '../../../../core/widgets/pagination/pagination_widget.dart';
import '../bloc/stock_bloc.dart';

class StockPaginationSection extends StatelessWidget {
  const StockPaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        if (state is! StockLoaded) return const SizedBox.shrink();

        final currentPage = state.currentPage;
        final itemsPerPage = state.itemsPerPage;
        final totalItems = state.totalItems;

        // Don't show pagination if no items
        if (totalItems == 0) return const SizedBox.shrink();

        final totalPages = (totalItems / itemsPerPage).ceil();

        final startItem = (currentPage - 1) * itemsPerPage + 1;
        final endItem = (startItem + state.stockItems.length - 1);

        return DataDrivenPagination(
          config: PaginationConfig(
            data: PaginationData(
              currentPage: currentPage,
              totalPages: totalPages,
              itemsPerPage: itemsPerPage,
              totalItems: totalItems,
              startIndex: startItem,
              endIndex: endItem,
              isLoading: false,
              itemLabel: 'produk',
            ),
            actions: PaginationActions(
              onPageChanged: (page) =>
                  context.read<StockBloc>().add(ChangePageEvent(page)),
              onItemsPerPageChanged: (count) {
                context.read<StockBloc>().add(ChangeItemsPerPageEvent(count));
              },
              onNextPage: currentPage < totalPages
                  ? () => context
                      .read<StockBloc>()
                      .add(ChangePageEvent(currentPage + 1))
                  : null,
              onPreviousPage: currentPage > 1
                  ? () => context
                      .read<StockBloc>()
                      .add(ChangePageEvent(currentPage - 1))
                  : null,
            ),
            theme: const PaginationTheme(
              primaryColor: AppColors.orangePrimary,
              backgroundColor: AppColors.white,
              textColor: AppColors.textGray3,
              disabledColor: AppColors.grey5,
              borderColor: AppColors.grey5,
            ),
          ),
        );
      },
    );
  }
}
