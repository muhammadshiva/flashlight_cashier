import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/constans/text_styles_const.dart';
import '../../../config/themes/app_colors.dart';
import '../../shared/models/pagination_config.dart';

/// Data-driven pagination component
class DataDrivenPagination extends StatelessWidget {
  final PaginationConfig config;

  const DataDrivenPagination({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return config.data.isLoading ? _buildLoadingState() : _buildSuccessState();
  }

  Widget _buildSuccessState() {
    return Container(
      padding: config.theme?.padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: config.theme?.backgroundColor ?? AppColors.white,
        border: Border(
            top: BorderSide(color: config.theme?.borderColor ?? AppColors.grey5, width: 1.w)),
        boxShadow: config.theme?.shadow != null
            ? [config.theme!.shadow!]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (config.showItemsPerPageDropdown) _buildLeftSection(),
          if (config.showPageNumbers) _buildRightSection(),
        ],
      ),
    );
  }

  Widget _buildLeftSection() {
    return Row(
      children: [
        _buildItemsPerPageDropdown(),
        SizedBox(width: 24.w),
        if (config.showInfoCounter) _buildInfoCounter(),
      ],
    );
  }

  Widget _buildInfoCounter() {
    return Text(
      config.data.totalItems == 0
          ? 'Menampilkan 0 dari 0 ${config.data.itemLabel}'
          : 'Menampilkan ${config.data.startIndex}-${config.data.endIndex} dari ${config.data.totalItems} ${config.data.itemLabel}',
      style: config.theme?.textStyle ??
          TextStyleConst.interRegular14.copyWith(color: AppColors.textGray3),
    );
  }

  Widget _buildItemsPerPageDropdown() {
    return Container(
      height: 32.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: config.theme?.borderColor ?? AppColors.grey5),
        borderRadius: BorderRadius.circular(config.theme?.borderRadius ?? 4.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: config.data.itemsPerPage,
          icon: Icon(Icons.keyboard_arrow_down,
              size: 16.w, color: config.theme?.textStyle?.color ?? AppColors.textGray3),
          style: config.theme?.textStyle ??
              TextStyleConst.interRegular14.copyWith(color: AppColors.textGray3),
          items: config.data.itemsPerPageOptions.map((count) {
            return DropdownMenuItem<int>(value: count, child: Text('$count per halaman'));
          }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              config.actions.onItemsPerPageChanged(newValue);
            }
          },
        ),
      ),
    );
  }

  Widget _buildRightSection() {
    return Row(
      children: [
        IconButton(
          onPressed: config.data.currentPage > 1 ? config.actions.onPreviousPage : null,
          icon: Icon(
            Icons.chevron_left,
            color: config.data.currentPage > 1
                ? config.theme?.primaryColor ?? AppColors.textGray3
                : config.theme?.disabledColor ?? AppColors.grey5,
          ),
        ),
        ..._buildPageNumbers(),
        IconButton(
          onPressed:
              config.data.currentPage < config.data.totalPages ? config.actions.onNextPage : null,
          icon: Icon(
            Icons.chevron_right,
            color: config.data.currentPage < config.data.totalPages
                ? config.theme?.primaryColor ?? AppColors.textGray3
                : config.theme?.disabledColor ?? AppColors.grey5,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers() {
    final pages = <Widget>[];
    final currentPage = config.data.currentPage;
    final totalPages = config.data.totalPages;

    // Calculate visible range
    int startPage = (currentPage - 2).clamp(1, totalPages);
    int endPage = (currentPage + 2).clamp(1, totalPages);

    // Add first page and ellipsis if needed
    if (startPage > 1) {
      pages.add(_buildPageNumber(1));
      if (startPage > 2) {
        pages.add(_buildPageDots());
      }
    }

    // Add visible pages
    for (int i = startPage; i <= endPage; i++) {
      pages.add(_buildPageNumber(i));
    }

    // Add last page and ellipsis if needed
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pages.add(_buildPageDots());
      }
      pages.add(_buildPageNumber(totalPages));
    }

    return pages;
  }

  Widget _buildPageNumber(int page) {
    final isCurrentPage = page == config.data.currentPage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: InkWell(
        onTap: () {
          // Validasi sebelum execute action
          if (page >= 1 && page <= config.data.totalPages) {
            config.actions.onPageChanged(page);
          }
        },
        child: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isCurrentPage
                ? config.theme?.primaryColor ?? AppColors.blackText900
                : Colors.transparent,
            borderRadius: BorderRadius.circular(config.theme?.borderRadius ?? 4.r),
          ),
          child: Center(
            child: Text(
              page.toString(),
              style: config.theme?.textStyle ??
                  TextStyleConst.interMedium14.copyWith(
                    color: isCurrentPage ? AppColors.white : AppColors.textGray3,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageDots() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        '...',
        style: config.theme?.textStyle ??
            TextStyleConst.interMedium14.copyWith(color: AppColors.textGray3),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: config.theme?.padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: config.theme?.backgroundColor ?? AppColors.white,
        border: Border(
            top: BorderSide(color: config.theme?.borderColor ?? AppColors.grey5, width: 1.w)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (config.showItemsPerPageDropdown) _buildLeftSection(),
          if (config.showPageNumbers) _buildRightSection(),
        ],
      ),
    );
  }
}
