import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constans/text_styles_const.dart';
import '../../../../config/themes/app_colors.dart';
import '../bloc/history_state.dart';

class HistoryStats extends StatelessWidget {
  final HistoryLoaded state;

  const HistoryStats({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(
          'Total Transaksi',
          state.historyOrders.length.toString(),
          Icons.receipt_long,
          AppColors.dashboardBlue,
          AppColors.dashboardBlueLight,
        ),
        SizedBox(width: 16.w),
        _buildStatCard(
          'Selesai',
          (state.statusCounts['completed'] ?? 0).toString(),
          Icons.check_circle,
          AppColors.success600,
          AppColors.success50,
        ),
        SizedBox(width: 16.w),
        _buildStatCard(
          'Lunas',
          (state.statusCounts['paid'] ?? 0).toString(),
          Icons.monetization_on,
          AppColors.dashboardGreen,
          AppColors.dashboardGreenLight,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.slate200),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 18.w),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyleConst.poppinsMedium14.copyWith(
                color: AppColors.slate800,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyleConst.poppinsBold18.copyWith(
                color: AppColors.slate800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
