import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../work_order/domain/entities/work_order.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';

class WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;
  final int index;
  final Customer? customer;
  final Vehicle? vehicle;
  final VoidCallback? onActionPressed;

  const WorkOrderCard({
    super.key,
    required this.workOrder,
    required this.index,
    this.customer,
    this.vehicle,
    this.onActionPressed,
  });

  String _shortenId(String id) {
    if (id.length > 8) {
      return '${id.substring(0, 8)}...';
    }
    return id;
  }

  String _getActionButtonLabel() {
    switch (workOrder.status.toLowerCase()) {
      case 'queued':
        return 'Mulai Cuci';
      case 'washing':
        return 'Mulai Kering';
      case 'drying':
        return 'Mulai Inspeksi';
      case 'inspection':
        return 'Selesai';
      case 'completed':
        return 'Proses Bayar';
      case 'paid':
        return 'Lihat Detail';
      default:
        return 'Proses';
    }
  }

  IconData _getActionButtonIcon() {
    switch (workOrder.status.toLowerCase()) {
      case 'queued':
        return Icons.local_car_wash;
      case 'washing':
        return Icons.air;
      case 'drying':
        return Icons.fact_check;
      case 'inspection':
        return Icons.check_circle;
      case 'completed':
        return Icons.payment;
      case 'paid':
        return Icons.visibility;
      default:
        return Icons.arrow_forward;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Queue Number Circle
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              workOrder.queueNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Main Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: ID + Time + Tags
                Row(
                  children: [
                    Text(
                      workOrder.workOrderCode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      workOrder.createdAt != null
                          ? DateFormat('HH:mm').format(workOrder.createdAt!)
                          : '-',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _StatusBadge(status: workOrder.status),
                    if (workOrder.estimatedTime.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 12, color: Color(0xFF64748B)),
                            const SizedBox(width: 4),
                            Text(
                              workOrder.estimatedTime,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),

                // Customer & Vehicle Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person,
                                  size: 16, color: Color(0xFF64748B)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  customer?.name ??
                                      'Cust: ${_shortenId(workOrder.customerId)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  size: 14, color: Color(0xFF64748B)),
                              const SizedBox(width: 8),
                              Text(
                                customer?.phoneNumber ?? '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.directions_car,
                                  size: 16, color: Color(0xFF64748B)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  vehicle != null
                                      ? '${vehicle!.vehicleBrand} ${vehicle!.vehicleSpecs}'
                                      : 'Vehicle: ${_shortenId(workOrder.vehicleDataId)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF475569),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const SizedBox(width: 24),
                              Text(
                                vehicle?.licensePlate ?? '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Action Button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onActionPressed,
                          icon: Icon(_getActionButtonIcon(), size: 18),
                          label: Text(_getActionButtonLabel()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getActionButtonColor(),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Services
                if (workOrder.services.isNotEmpty) ...[
                  Row(
                    children: const [
                      Icon(Icons.build, size: 14, color: Color(0xFF94A3B8)),
                      SizedBox(width: 6),
                      Text(
                        'Layanan:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: workOrder.services.map((service) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFBFDBFE),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          service.service?.name ??
                              'Svc: ${_shortenId(service.serviceId)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Products (F&B)
                if (workOrder.products.isNotEmpty) ...[
                  Row(
                    children: const [
                      Icon(Icons.fastfood, size: 14, color: Color(0xFF94A3B8)),
                      SizedBox(width: 6),
                      Text(
                        'F&B:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: workOrder.products.map((product) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFFDE68A),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${product.product?.name ?? 'Prod: ${_shortenId(product.productId)}'}'
                          '${product.quantity > 1 ? ' (${product.quantity}x)' : ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF92400E),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Price
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                          .format(workOrder.totalPrice),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Show products count as upsell indicator
                    if (workOrder.products.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.local_offer,
                                size: 12, color: Color(0xFFD97706)),
                            SizedBox(width: 4),
                            Text(
                              'Upsell',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionButtonColor() {
    switch (workOrder.status.toLowerCase()) {
      case 'queued':
        return const Color(0xFF1E40AF); // Blue
      case 'washing':
        return const Color(0xFFEA580C); // Orange
      case 'drying':
        return const Color(0xFF7C3AED); // Purple
      case 'inspection':
        return const Color(0xFF059669); // Green
      case 'completed':
        return const Color(0xFF16A34A); // Dark Green
      case 'paid':
        return const Color(0xFF64748B); // Gray
      default:
        return const Color(0xFF1E293B); // Default Dark
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status.toLowerCase()) {
      case 'queued':
        bgColor = const Color(0xFFDBEAFE);
        textColor = const Color(0xFF1E40AF);
        text = 'ANTRI';
        break;
      case 'washing':
        bgColor = const Color(0xFFFFEDD5);
        textColor = const Color(0xFF9A3412);
        text = 'CUCI';
        break;
      case 'drying':
        bgColor = const Color(0xFFE9D5FF);
        textColor = const Color(0xFF6B21A8);
        text = 'KERING';
        break;
      case 'inspection':
        bgColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF065F46);
        text = 'INSPEKSI';
        break;
      case 'completed':
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        text = 'SELESAI';
        break;
      case 'paid':
        bgColor = const Color(0xFFE0E7FF);
        textColor = const Color(0xFF4338CA);
        text = 'LUNAS';
        break;
      default:
        bgColor = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF475569);
        text = status.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
