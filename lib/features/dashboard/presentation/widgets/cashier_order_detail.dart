import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';

class CashierOrderDetail extends StatelessWidget {
  final WorkOrder? selectedOrder;
  final Customer? customer;
  final Vehicle? vehicle;
  final VoidCallback? onPay;
  final Function(String item)? onAddService; // Changed to String for mock simplicity
  final Function(Map<String, dynamic> item)? onRemove;

  const CashierOrderDetail({
    super.key,
    required this.selectedOrder,
    this.customer,
    this.vehicle,
    this.onPay,
    this.onAddService,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedOrder == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.point_of_sale, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                'Select an order to view details',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final order = selectedOrder!;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header
          _OrderHeader(order: order, customer: customer, vehicle: vehicle),
          const Divider(height: 1),
          // Items List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Items',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => onAddService?.call('OPEN_DIALOG'),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add Item'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.orangePrimary,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...order.services.map((s) => _OrderItemRow(
                      name: s.service?.name ?? 'Service',
                      quantity: s.quantity,
                      price: s.priceAtOrder,
                      type: 'Service',
                      id: s.id,
                      onRemove: () => onRemove?.call({'id': s.id, 'type': 'Service'}),
                    )),
                ...order.products.map((p) => _OrderItemRow(
                      name: p.product?.name ?? 'Product',
                      quantity: p.quantity,
                      price: p.priceAtOrder,
                      type: 'Product',
                      id: p.id,
                      onRemove: () => onRemove?.call({'id': p.id, 'type': 'Product'}),
                    )),
                if (order.services.isEmpty && order.products.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: Text('No items in this order')),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Payment Section (Stick to bottom)
          _PaymentSection(
            order: order,
            customer: customer,
            onPay: onPay,
          ),
        ],
      ),
    );
  }
}

class QuickActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const QuickActionChip({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFE2E8F0)),
      labelStyle: const TextStyle(
        color: Color(0xFF475569),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  final WorkOrder order;
  final Customer? customer;
  final Vehicle? vehicle;

  const _OrderHeader({
    required this.order,
    required this.customer,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order.workOrderCode}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Q-${order.queueNumber}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.estimatedTime,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _StatusBadgeLarge(status: order.status),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  label: 'Customer',
                  value: customer?.name ?? 'Guest Customer',
                  icon: Icons.person,
                ),
              ),
              Expanded(
                child: _InfoTile(
                  label: 'Vehicle',
                  value: vehicle != null
                      ? '${vehicle!.vehicleBrand} ${vehicle!.licensePlate}'
                      : 'No Vehicle',
                  icon: Icons.directions_car,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;
  final String type;
  final String id;
  final VoidCallback? onRemove;

  const _OrderItemRow({
    required this.name,
    required this.quantity,
    required this.price,
    required this.type,
    required this.id,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color:
                  type == 'Service' ? Colors.blue.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type[0],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: type == 'Service' ? Colors.blue : Colors.orange,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  '$quantity x ${price.toCurrencyFormat()}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (price * quantity).toCurrencyFormat(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFFEF4444)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: 'Remove Item',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentSection extends StatelessWidget {
  final WorkOrder order;
  final Customer? customer;
  final VoidCallback? onPay;

  const _PaymentSection({
    required this.order,
    this.customer,
    this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                order.totalPrice.toCurrencyFormat(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PaymentDialog(
                    order: order,
                    customer: customer, // Need to pass customer
                  ),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text('Process Payment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadgeLarge extends StatelessWidget {
  final String status;

  const _StatusBadgeLarge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;
    String label;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'paid':
        bg = const Color(0xFFDCFCE7);
        text = const Color(0xFF166534);
        label = 'Completed';
        break;
      case 'washing':
      case 'drying':
      case 'inspection':
        bg = const Color(0xFFDBEAFE);
        text = const Color(0xFF1E40AF);
        label = 'In Progress';
        break;
      case 'cancelled':
        bg = const Color(0xFFFEE2E2);
        text = const Color(0xFF991B1B);
        label = 'Cancelled';
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        text = const Color(0xFF64748B);
        label = 'Queued';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }
}
