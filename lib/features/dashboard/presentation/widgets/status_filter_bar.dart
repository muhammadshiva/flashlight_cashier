import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class StatusFilterBar extends StatelessWidget {
  const StatusFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is! DashboardLoaded) return const SizedBox.shrink();

        final counts = state.statusCounts;
        final selected = state.selectedStatus;

        // Helper to find count by status name from list
        int getCount(String status) {
          final found = counts.where((s) => s.name == status);
          if (found.isNotEmpty) {
            return found.first.count;
          }
          return 0;
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'Semua',
                count: getCount('Semua'),
                isActive: selected == 'Semua',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'Semua')),
              ),
              SizedBox(width: 12.w),
              _FilterChip(
                label: 'queued',
                count: getCount('queued'),
                isActive: selected.toLowerCase() == 'queued',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'queued')),
              ),
              SizedBox(width: 12.w),
              _FilterChip(
                label: 'washing',
                count: getCount('washing'),
                isActive: selected.toLowerCase() == 'washing',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'washing')),
              ),
              SizedBox(width: 12.w),
              _FilterChip(
                label: 'drying',
                count: getCount('drying'),
                isActive: selected.toLowerCase() == 'drying',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'drying')),
              ),
              SizedBox(width: 12.w),
              _FilterChip(
                label: 'inspection',
                count: getCount('inspection'),
                isActive: selected.toLowerCase() == 'inspection',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'inspection')),
              ),
              SizedBox(width: 12.w),
              _FilterChip(
                label: 'completed', // 'Ready' in UI might map to 'completed' API status
                count: getCount('completed'),
                isActive: selected.toLowerCase() == 'completed',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'completed')),
              ),
              SizedBox(width: 12.w),
              _FilterChip(
                label: 'paid',
                count: getCount('paid'),
                isActive: selected.toLowerCase() == 'paid',
                onTap: () =>
                    context.read<DashboardBloc>().add(const FilterWorkOrders(status: 'paid')),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        decoration: BoxDecoration(
          color: isActive ? AppColors.slate800 : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isActive ? AppColors.slate800 : AppColors.slate200,
          ),
        ),
        child: Row(
          children: [
            Text(
              label[0].toUpperCase() + label.substring(1),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.slate500,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: isActive ? AppColors.slate700 : AppColors.slate100,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : AppColors.slate500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
