import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';

class CashierOrderList extends StatelessWidget {
  final List<WorkOrder> orders;
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;
  final String? selectedOrderId;
  final Function(WorkOrder) onOrderSelected;

  const CashierOrderList({
    super.key,
    required this.orders,
    required this.customers,
    required this.vehicles,
    this.selectedOrderId,
    required this.onOrderSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No active orders',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        final customer = customers[order.customerId];
        final vehicle = vehicles[order.vehicleDataId];
        final isSelected = order.id == selectedOrderId;

        return _OrderCard(
          order: order,
          customer: customer,
          vehicle: vehicle,
          isSelected: isSelected,
          onTap: () => onOrderSelected(order),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final WorkOrder order;
  final Customer? customer;
  final Vehicle? vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.customer,
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on selection and status
    final cardColor = isSelected ? const Color(0xFFF0F9FF) : Colors.white;
    final borderColor =
        isSelected ? const Color(0xFF0EA5E9) : const Color(0xFFE2E8F0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Queue Number Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Q-${order.queueNumber}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                _StatusBadgeSmall(status: order.status),
              ],
            ),
            const SizedBox(height: 12),
            // Vehicle Info
            Text(
              vehicle != null
                  ? '${vehicle!.vehicleBrand} - ${vehicle!.licensePlate}'
                  : 'Unknown Vehicle',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            // Customer Name
            Row(
              children: [
                Icon(Icons.person_outline, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  customer?.name ?? 'Guest',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // Total & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.totalPrice.toCurrencyFormat(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  order.estimatedTime,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadgeSmall extends StatelessWidget {
  final String status;

  const _StatusBadgeSmall({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed':
      case 'paid':
        color = Colors.green;
        break;
      case 'washing':
      case 'drying':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
