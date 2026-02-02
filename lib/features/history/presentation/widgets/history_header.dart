import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constans/text_styles_const.dart';
import '../../../../config/themes/app_colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryHeader extends StatelessWidget {
  final HistoryLoaded state;

  const HistoryHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Transaksi',
              style: TextStyleConst.poppinsBold24.copyWith(
                color: AppColors.slate800,
              ),
            ),
            SizedBox(height: 4.w),
            Row(
              children: [
                Text(
                  'Dashboard',
                  style: TextStyleConst.poppinsRegular14.copyWith(
                    color: AppColors.slate500,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.circle, size: 4.w, color: AppColors.slate300),
                SizedBox(width: 8.w),
                Text(
                  'Riwayat',
                  style: TextStyleConst.poppinsMedium14.copyWith(
                    color: AppColors.orangePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: AppColors.slate400,
                    size: 20.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context.read<HistoryBloc>().add(FilterHistory(searchQuery: value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari WO, Pelanggan, Plat...',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyleConst.poppinsRegular14.copyWith(
                          color: AppColors.slate400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            OutlinedButton.icon(
              onPressed: () {
                _showFilterDialog(context, state);
              },
              icon: Icon(Icons.filter_list, size: 18.w),
              label: Text(state.selectedStatus == 'Semua' ? 'Filter' : state.selectedStatus),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.slate500,
                side: BorderSide(
                    color: state.selectedStatus == 'Semua'
                        ? AppColors.slate200
                        : AppColors.orangePrimary),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.w,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                textStyle: TextStyleConst.poppinsMedium14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context, HistoryLoaded state) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Filter Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterOption(context, dialogContext, 'Semua', state),
            _buildFilterOption(context, dialogContext, 'completed', state, label: 'Selesai'),
            _buildFilterOption(context, dialogContext, 'paid', state, label: 'Lunas'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(
      BuildContext context, BuildContext dialogContext, String status, HistoryLoaded state,
      {String? label}) {
    final isSelected = state.selectedStatus == status;
    return ListTile(
      title: Text(label ?? status),
      selected: isSelected,
      selectedColor: AppColors.orangePrimary,
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        context.read<HistoryBloc>().add(FilterHistory(status: status));
        Navigator.pop(dialogContext);
      },
    );
  }
}
