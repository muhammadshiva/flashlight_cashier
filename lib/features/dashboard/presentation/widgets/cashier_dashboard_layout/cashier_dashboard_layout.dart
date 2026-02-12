import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flutter/material.dart';

import 'components/order_detail_panel.dart';
import 'components/order_list_panel.dart';

class CashierDashboardLayout extends StatefulWidget {
  final DashboardLoaded state;

  const CashierDashboardLayout({super.key, required this.state});

  @override
  State<CashierDashboardLayout> createState() => _CashierDashboardLayoutState();
}

class _CashierDashboardLayoutState extends State<CashierDashboardLayout> {
  String? _selectedOrderId;

  @override
  void didUpdateWidget(covariant CashierDashboardLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the list changes and the selected order is no longer in it, deselect?
    // Or if initial load, maybe select the first one?
    // For now, keep selection if possible.
  }

  @override
  Widget build(BuildContext context) {
    // Find selected order object
    final selectedOrder =
        widget.state.filteredOrders.where((o) => o.id == _selectedOrderId).firstOrNull;

    final customer =
        selectedOrder != null ? widget.state.customers[selectedOrder.customerId] : null;
    final vehicle =
        selectedOrder != null ? widget.state.vehicles[selectedOrder.vehicleDataId] : null;

    return Row(
      children: [
        //* Left Panel: Order List
        OrderListPanel(
          state: widget.state,
          selectedOrderId: _selectedOrderId,
          onOrderSelected: (order) {
            setState(() {
              _selectedOrderId = order.id;
            });
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
