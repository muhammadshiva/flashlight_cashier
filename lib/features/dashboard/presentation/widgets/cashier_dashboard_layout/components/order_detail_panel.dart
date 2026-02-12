import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_order_detail.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/service_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailPanel extends StatelessWidget {
  final dynamic selectedOrder; // Using dynamic because types are inferred in usage
  final dynamic customer;
  final dynamic vehicle;

  const OrderDetailPanel({
    super.key,
    required this.selectedOrder,
    required this.customer,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
