import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/dashboard_empty_state.dart';

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
      return const Center(child: DashboardEmptyState());
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
    // Premium Design Constants
    final borderRadius = BorderRadius.circular(16);
    final cardColor = isSelected ? const Color(0xFFF8FAFC) : Colors.white;
    const primaryColor = Color(0xFF0EA5E9); // Sky blue
    final borderColor = isSelected ? primaryColor : Colors.grey.shade200;

    return Container(
      margin: const EdgeInsets.only(bottom: 4), // Add space for shadow
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor,
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: [
          // Soft, layered shadows for depth
          BoxShadow(
            color:
                const Color(0xFF64748B).withOpacity(isSelected ? 0.08 : 0.03),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color:
                const Color(0xFF64748B).withOpacity(isSelected ? 0.04 : 0.02),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                // Selection Indicator Strip
                if (isSelected)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF0EA5E9),
                            Color(0xFF38BDF8),
                          ],
                        ),
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Queue & Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.confirmation_number_outlined,
                                    size: 14, color: Colors.blueGrey[600]),
                                const SizedBox(width: 6),
                                Text(
                                  'Q-${order.queueNumber}',
                                  style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _StatusBadgeSmall(status: order.status),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Vehicle Info (Hero Content)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryColor.withOpacity(0.1)
                                  : const Color(0xFFF1F5F9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.directions_car_filled_rounded,
                              color: isSelected
                                  ? primaryColor
                                  : Colors.blueGrey[400],
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehicle != null
                                      ? vehicle!.licensePlate
                                      : 'Unknown',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: Color(0xFF1E293B),
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  vehicle != null
                                      ? vehicle!.vehicleBrand
                                      : 'No Detail',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blueGrey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Divider(height: 1, color: Colors.blueGrey[50]),
                      const SizedBox(height: 12),

                      // Bottom: Customer & Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left: Customer & Time
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person,
                                        size: 14, color: Colors.blueGrey[400]),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        customer?.name ?? 'Guest',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.blueGrey[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_filled,
                                        size: 14, color: Colors.blueGrey[400]),
                                    const SizedBox(width: 4),
                                    Text(
                                      order.estimatedTime,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Right: Price
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryColor.withOpacity(0.08)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order.totalPrice.toCurrencyFormat(),
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: isSelected
                                    ? const Color(0xFF0369A1)
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    Color bg;
    Color fg;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'paid':
        bg = const Color(0xFFDCFCE7); // Green 100
        fg = const Color(0xFF166534); // Green 800
        break;
      case 'washing':
      case 'drying':
        bg = const Color(0xFFDBEAFE); // Blue 100
        fg = const Color(0xFF1E40AF); // Blue 800
        break;
      case 'finishing':
        bg = const Color(0xFFF3E8FF); // Purple 100
        fg = const Color(0xFF6B21A8); // Purple 800
        break;
      case 'pending':
        bg = const Color(0xFFFEF9C3); // Yellow 100
        fg = const Color(0xFF854D0E); // Yellow 800
        break;
      default:
        bg = const Color(0xFFF1F5F9); // Slate 100
        fg = const Color(0xFF475569); // Slate 600
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20), // Pill shape
        border: Border.all(
            color: bg == const Color(0xFFF1F5F9)
                ? Colors.blueGrey[200]!
                : Colors.transparent),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: fg,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
