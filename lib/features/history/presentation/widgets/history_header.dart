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
            PopupMenuButton<String>(
              offset: Offset(0, 50.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              color: Colors.white,
              elevation: 8,
              onSelected: (value) {
                context.read<HistoryBloc>().add(FilterHistory(status: value));
              },
              itemBuilder: (context) => [
                _buildPopupItem('Semua', Icons.list, state.selectedStatus),
                _buildPopupItem('completed', Icons.check_circle_outline, state.selectedStatus,
                    label: 'Selesai'),
                _buildPopupItem('paid', Icons.payments_outlined, state.selectedStatus,
                    label: 'Lunas'),
              ],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: state.selectedStatus == 'Semua'
                        ? AppColors.slate200
                        : AppColors.orangePrimary,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.filter_list, size: 18.w, color: AppColors.slate500),
                    SizedBox(width: 8.w),
                    Text(
                      state.selectedStatus == 'Semua' ? 'Filter' : _getLabel(state.selectedStatus),
                      style: TextStyleConst.poppinsMedium14.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupItem(String value, IconData icon, String selectedStatus,
      {String? label}) {
    final isSelected = selectedStatus == value;
    final displayLabel = label ?? value;
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.w,
            color: isSelected ? AppColors.orangePrimary : const Color(0xFF64748B),
          ),
          SizedBox(width: 12.w),
          Text(
            displayLabel,
            style: TextStyle(
              fontSize: 14.sp,
              color: isSelected ? AppColors.orangePrimary : const Color(0xFF1E293B),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          if (isSelected) ...[
            const Spacer(),
            Icon(Icons.check, size: 18.w, color: AppColors.orangePrimary),
          ],
        ],
      ),
    );
  }

  String _getLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Selesai';
      case 'paid':
        return 'Lunas';
      default:
        return status;
    }
  }
}
