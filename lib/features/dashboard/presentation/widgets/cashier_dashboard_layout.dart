import 'package:flashlight_pos/features/dashboard/presentation/widgets/service_selection_dialog.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_order_detail.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_order_list.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/status_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import 'package:intl/intl.dart';
import 'dart:async';

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
    final selectedOrder = widget.state.filteredOrders
        .where((o) => o.id == _selectedOrderId)
        .firstOrNull;

    final customer = selectedOrder != null
        ? widget.state.customers[selectedOrder.customerId]
        : null;
    final vehicle = selectedOrder != null
        ? widget.state.vehicles[selectedOrder.vehicleDataId]
        : null;

    return Row(
      children: [
        //* Left Panel: Order List
        Expanded(
          flex: 6,
          child: Container(
            color: const Color(0xFFF1F5F9), // Light bg for list
            child: Column(
              children: [
                // Top Bar for Left Panel
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const _ClockWidget(),
                          const Spacer(),
                          // Search Bar
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                context
                                    .read<DashboardBloc>()
                                    .add(FilterWorkOrders(searchQuery: value));
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                    color: Color(0xFF94A3B8), fontSize: 13),
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xFF94A3B8), size: 18),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Reusing the existing Filter Bar
                      const StatusFilterBar(),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // List
                Expanded(
                  child: CashierOrderList(
                    orders: widget.state.filteredOrders,
                    customers: widget.state.customers,
                    vehicles: widget.state.vehicles,
                    selectedOrderId: _selectedOrderId,
                    onOrderSelected: (order) {
                      setState(() {
                        _selectedOrderId = order.id;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Vertical Divider
        const VerticalDivider(width: 1, color: Color(0xFFE2E8F0)),
        //* Right Panel: Order Detail
        Expanded(
          flex: 4, // Slightly wider for details
          child: CashierOrderDetail(
            selectedOrder: selectedOrder,
            customer: customer,
            vehicle: vehicle,
            onPay: () {
              // Handle Payment
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment flow - Not implemented')),
              );
            },
            onAddService: (item) {
              if (item == 'OPEN_DIALOG') {
                showDialog(
                  context: context,
                  builder: (context) => const ServiceSelectionDialog(),
                ).then((selectedItem) {
                  if (selectedItem != null && selectedItem is Map) {
                    final itemMap = selectedItem as Map<String, dynamic>;
                    context.read<DashboardBloc>().add(AddWorkOrderItemEvent(
                          workOrderId: selectedOrder!.id,
                          item: itemMap,
                          type: itemMap['type'] ?? 'Service',
                        ));
                  }
                });
              } else {
                // Quick Add (Assume Service and Mock Price)
                // In real app, we'd fetch the service details by name
                final quickItem = {
                  'name': item,
                  'price': 35000, // Mock default price
                };
                context.read<DashboardBloc>().add(AddWorkOrderItemEvent(
                      workOrderId: selectedOrder!.id,
                      item: quickItem,
                      type: 'Service',
                    ));
              }
            },
            onRemove: (itemMap) {
              context.read<DashboardBloc>().add(RemoveWorkOrderItemEvent(
                    workOrderId: selectedOrder!.id,
                    itemId: itemMap['id'],
                    type: itemMap['type'],
                  ));
            },
          ),
        ),
      ],
    );
  }
}

class _ClockWidget extends StatefulWidget {
  const _ClockWidget();

  @override
  State<_ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<_ClockWidget> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('HH:mm:ss').format(_currentTime),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: 1,
          ),
        ),
        Text(
          DateFormat('EEE, d MMMM yyyy').format(_currentTime),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
