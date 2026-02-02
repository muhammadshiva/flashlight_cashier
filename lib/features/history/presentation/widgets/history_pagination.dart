import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/app_colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryPagination extends StatelessWidget {
  const HistoryPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is! HistoryLoaded) return const SizedBox.shrink();

        final currentPage = state.currentPage;
        final itemsPerPage = state.itemsPerPage;
        final totalItems = state.totalItems;
        final totalPages = (totalItems / itemsPerPage).ceil();

        final startItem = (currentPage - 1) * itemsPerPage + 1;
        final endItem = (startItem + state.displayedOrders.length - 1);

        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('View', style: TextStyle(color: AppColors.slate500)),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Row(
                      children: [
                        Text('$itemsPerPage', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.keyboard_arrow_down, size: 16.w),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const Text('entry per page', style: TextStyle(color: AppColors.slate500)),
                ],
              ),
              Row(
                children: [
                  Text('Showing $startItem-$endItem of $totalItems entries',
                      style: const TextStyle(color: AppColors.slate500)),
                  SizedBox(width: 24.w),
                  IconButton(
                      onPressed: currentPage > 1
                          ? () => context.read<HistoryBloc>().add(ChangePageEvent(currentPage - 1))
                          : null,
                      icon: Icon(Icons.chevron_left,
                          color: currentPage > 1 ? AppColors.slate500 : AppColors.slate300)),
                  ...List.generate(totalPages, (index) {
                    final page = index + 1;
                    if (totalPages > 7 &&
                        (page > 2 &&
                            page < totalPages - 1 &&
                            (page < currentPage - 1 || page > currentPage + 1))) {
                      return page == currentPage - 2 || page == currentPage + 2
                          ? const Text('...', style: TextStyle(color: AppColors.slate500))
                          : const SizedBox.shrink();
                    }
                    return _buildPageNumber(context, page, isActive: page == currentPage);
                  }),
                  IconButton(
                      onPressed: currentPage < totalPages
                          ? () => context.read<HistoryBloc>().add(ChangePageEvent(currentPage + 1))
                          : null,
                      icon: Icon(Icons.chevron_right,
                          color:
                              currentPage < totalPages ? AppColors.slate500 : AppColors.slate300)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageNumber(BuildContext context, int number, {required bool isActive}) {
    return InkWell(
      onTap: () => context.read<HistoryBloc>().add(ChangePageEvent(number)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.orangePrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.slate500,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
