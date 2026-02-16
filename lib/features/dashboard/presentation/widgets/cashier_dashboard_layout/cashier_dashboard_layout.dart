import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/order_detail_panel.dart';
import 'components/order_list_panel.dart';

class CashierDashboardLayout extends StatelessWidget {
  final DashboardLoaded state;

  const CashierDashboardLayout({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final selectedOrderId = state.selectedOrderId;

    // Find selected order object
    final selectedOrder =
        state.filteredOrders.where((o) => o.id == selectedOrderId).firstOrNull;

    final customer =
        selectedOrder != null ? state.customers[selectedOrder.customerId] : null;
    final vehicle =
        selectedOrder != null ? state.vehicles[selectedOrder.vehicleDataId] : null;

    return Row(
      children: [
        //* Left Panel: Order List
        OrderListPanel(
          state: state,
          selectedOrderId: selectedOrderId,
          onOrderSelected: (order) {
            context.read<DashboardBloc>().add(SelectWorkOrder(order.id));
          },
        ),
        // Vertical Divider
        const VerticalDivider(width: 1, color: Color(0xFFE2E8F0)),
        //* Right Panel: Order Detail
        OrderDetailPanel(
          selectedOrder: selectedOrder,
          customer: customer,
          vehicle: vehicle,
        ),
      ],
    );
  }
}
