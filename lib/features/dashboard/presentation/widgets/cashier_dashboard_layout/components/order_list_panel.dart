import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_order_list.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/status_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'clock_widget.dart';

class OrderListPanel extends StatefulWidget {
  final DashboardLoaded state;
  final String? selectedOrderId;
  final ValueChanged<dynamic>
      onOrderSelected; // Using dynamic because order type isn't fully visible here, but likely WorkOrder

  const OrderListPanel({
    super.key,
    required this.state,
    required this.selectedOrderId,
    required this.onOrderSelected,
  });

  @override
  State<OrderListPanel> createState() => _OrderListPanelState();
}

class _OrderListPanelState extends State<OrderListPanel> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() {
    context.read<DashboardBloc>().add(RefreshDashboard());
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        color: AppColors.slate100, // Light bg for list
        child: Column(
          children: [
            // Top Bar for Left Panel
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        const ClockWidget(),
                        const Spacer(),
                        // Search Bar
                        Container(
                          width: 500.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: AppColors.slate100,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.slate200),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<DashboardBloc>()
                                  .add(FilterWorkOrders(searchQuery: value));
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: AppColors.slate400, fontSize: 13.sp),
                              prefixIcon: Icon(Icons.search, color: AppColors.slate400, size: 18.w),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.w),
                  // Reusing the existing Filter Bar
                  const StatusFilterBar(),
                ],
              ),
            ),
            Divider(height: 1.w),
            // List
            Expanded(
              child: CashierOrderList(
                orders: widget.state.filteredOrders,
                customers: widget.state.customers,
                vehicles: widget.state.vehicles,
                selectedOrderId: widget.selectedOrderId,
                onOrderSelected: widget.onOrderSelected,
                refreshController: _refreshController,
                onRefresh: _onRefresh,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
