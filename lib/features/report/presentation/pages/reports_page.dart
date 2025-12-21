import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/constans/text_styles_const.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../injection_container.dart';
import '../bloc/reports_bloc.dart';
import '../bloc/reports_event.dart';
import '../bloc/reports_state.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReportsBloc>()..add(LoadReports()),
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        appBar: AppBar(
          title: Text('Laporan', style: TextStyleConst.poppinsSemiBold20),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.blackText900,
          elevation: 0,
        ),
        body: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error600,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      style: TextStyleConst.poppinsSemiBold18.copyWith(color: AppColors.error600),
                    ),
                  ],
                ),
              );
            } else if (state is ReportsLoaded) {
              final sortedDates = state.dailyRevenue.keys.toList()..sort((a, b) => b.compareTo(a));

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    Text(
                      'Laporan Penjualan',
                      style: TextStyleConst.poppinsBold24.copyWith(color: AppColors.blackText900),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ringkasan laporan penjualan harian dan per layanan',
                      style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
                    ),
                    const SizedBox(height: 24),

                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Total Motor Dicuci',
                            state.totalCarsProcessed.toString(),
                            Icons.directions_car,
                            AppColors.dashboardBlue,
                            AppColors.dashboardBlueLight,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Total Pendapatan',
                            CurrencyFormatter.format(
                              state.dailyRevenue.values.fold(0, (sum, amount) => sum + amount),
                            ),
                            Icons.attach_money,
                            AppColors.dashboardGreen,
                            AppColors.dashboardGreenLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Service Revenue Section
                    Text(
                      'Pendapatan per Layanan',
                      style: TextStyleConst.poppinsBold20.copyWith(color: AppColors.blackText900),
                    ),
                    const SizedBox(height: 16),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: .5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ringkasan pendapatan berdasarkan jenis layanan',
                              style: TextStyleConst.poppinsMedium14
                                  .copyWith(color: AppColors.textGray3),
                            ),
                            const SizedBox(height: 16),
                            ...state.serviceRevenue.entries.map((e) {
                              return _buildServiceRevenueItem(e.key, e.value);
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Daily Revenue Section
                    Text(
                      'Pendapatan Harian',
                      style: TextStyleConst.poppinsBold20.copyWith(color: AppColors.blackText900),
                    ),
                    const SizedBox(height: 16),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: .5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ringkasan pendapatan harian',
                              style: TextStyleConst.poppinsMedium14
                                  .copyWith(color: AppColors.textGray3),
                            ),
                            const SizedBox(height: 16),
                            ...sortedDates.map((date) {
                              return _buildDailyRevenueItem(date, state.dailyRevenue[date]!);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderGray, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: .5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyleConst.poppinsRegular12.copyWith(color: AppColors.textGray3),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: TextStyleConst.poppinsBold24.copyWith(color: AppColors.blackText900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceRevenueItem(String serviceName, int revenue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: TextStyleConst.poppinsSemiBold16.copyWith(color: AppColors.blackText900),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total pendapatan',
                  style: TextStyleConst.poppinsRegular12.copyWith(color: AppColors.textGray3),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.format(revenue),
            style: TextStyleConst.poppinsBold18.copyWith(color: AppColors.dashboardGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyRevenueItem(DateTime date, int revenue) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, d MMMM yyyy').format(date),
                  style: TextStyleConst.poppinsSemiBold16.copyWith(color: AppColors.blackText900),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pendapatan',
                  style: TextStyleConst.poppinsRegular12.copyWith(color: AppColors.textGray3),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.format(revenue),
            style: TextStyleConst.poppinsBold18.copyWith(color: AppColors.dashboardBlue),
          ),
        ],
      ),
    );
  }
}
