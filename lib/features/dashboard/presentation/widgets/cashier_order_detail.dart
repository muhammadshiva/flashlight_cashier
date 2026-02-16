import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/payment_dialog.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              Icon(Icons.point_of_sale, size: 64.w, color: Colors.grey[300]),
              SizedBox(height: 16.w),
              Text(
                'Select an order to view details',
                style: TextStyle(
                  fontSize: 16.sp,
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
          Divider(height: 1.w),
          // Items List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Items',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => onAddService?.call('OPEN_DIALOG'),
                      icon: Icon(Icons.add, size: 16.w),
                      label: const Text('Add Item'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.orangePrimary,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.w),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.w),
                    child: const Center(child: Text('No items in this order')),
                  ),
              ],
            ),
          ),
          Divider(height: 1.w),
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
      side: const BorderSide(color: AppColors.slate200),
      labelStyle: TextStyle(
        color: AppColors.slate600,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
      padding: EdgeInsets.all(24.w),
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
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.slate800,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                        decoration: BoxDecoration(
                          color: AppColors.slate800,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Q-${order.queueNumber}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        order.estimatedTime,
                        style: TextStyle(
                          color: AppColors.slate500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _StatusBadgeLarge(status: order.status),
            ],
          ),
          SizedBox(height: 24.w),
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
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.slate100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.w, color: AppColors.slate500),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12.sp, color: AppColors.slate400)),
              Text(value,
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.slate700),
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
      padding: EdgeInsets.only(bottom: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
            decoration: BoxDecoration(
              color:
                  type == 'Service' ? Colors.blue.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              type[0],
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: type == 'Service' ? Colors.blue : Colors.orange,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate800,
                  ),
                ),
                Text(
                  '$quantity x ${price.toCurrencyFormat()}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.slate500,
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
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.slate800,
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: onRemove,
                icon: Icon(Icons.delete_outline, size: 20.w, color: const Color(0xFFEF4444)),
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, -5.w),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.slate500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                order.totalPrice.toCurrencyFormat(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.slate800,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.w),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final dashboardBloc = context.read<DashboardBloc>();
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: dashboardBloc,
                    child: PaymentDialog(
                      order: order,
                      customer: customer,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text('Process Payment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
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
        bg = AppColors.slate100;
        text = AppColors.slate500;
        label = 'Queued';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }
}
