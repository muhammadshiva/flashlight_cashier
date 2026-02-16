import 'package:flashlight_pos/config/constans/app_lottie_const.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/dashboard_empty_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/order_card.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CashierOrderList extends StatelessWidget {
  final List<WorkOrder> orders;
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;
  final String? selectedOrderId;
  final Function(WorkOrder) onOrderSelected;
  final RefreshController refreshController;
  final VoidCallback onRefresh;

  const CashierOrderList({
    super.key,
    required this.orders,
    required this.customers,
    required this.vehicles,
    this.selectedOrderId,
    required this.onOrderSelected,
    required this.refreshController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(child: DashboardEmptyState());
    }

    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      header: _buildSmartRefresherHeader(),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        itemCount: orders.length,
        separatorBuilder: (context, index) => SizedBox(height: 8.w),
        itemBuilder: (context, index) {
          final order = orders[index];
          final customer = customers[order.customerId];
          final vehicle = vehicles[order.vehicleDataId];
          final isSelected = order.id == selectedOrderId;

          return OrderCard(
            order: order,
            customer: customer,
            vehicle: vehicle,
            isSelected: isSelected,
            onTap: () => onOrderSelected(order),
          );
        },
      ),
    );
  }

  Widget _buildSmartRefresherHeader() {
    return CustomHeader(
      height: 80.w,
      builder: (context, mode) {
        Widget body;
        if (mode == RefreshStatus.completed) {
          body = Lottie.asset(
            AppLottieConst.success,
            width: 120.w,
            height: 120.w,
          );
        } else {
          body = Lottie.asset(
            AppLottieConst.loading,
            width: 60.w,
            height: 60.w,
          );
        }
        return SizedBox(
          height: 80.w,
          child: Center(child: body),
        );
      },
    );
  }
}
