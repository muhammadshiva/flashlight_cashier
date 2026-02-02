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
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.slate200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 24.w),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleConst.poppinsMedium14.copyWith(
                    color: AppColors.slate500,
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  value,
                  style: TextStyleConst.poppinsBold24.copyWith(
                    color: AppColors.slate800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
