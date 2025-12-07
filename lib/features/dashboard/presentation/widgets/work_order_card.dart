import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../work_order/domain/entities/work_order.dart';

class WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;
  final int index;
  final String? customerName;
  final String? vehicleName;

  const WorkOrderCard({
    super.key,
    required this.workOrder,
    required this.index,
    this.customerName,
    this.vehicleName,
  });

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
              '${index + 1}', // Using index as mock queue number if needed, or workOrder.queueNumber
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
                  ],
                ),
                const SizedBox(height: 12),

                // Customer & Vehicle Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customerName ??
                              'Customer ID: ${workOrder.customerId}', // Placeholder until expanded data
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '0812-3456-7890', // Hardcoded mockup for now
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Action Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E293B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                              'Mulai Cuci'), // Dynamic action based on status in future
                        ),
                        const SizedBox(height: 12),
                        Text(
                          vehicleName ??
                              'Vehicle ID: ${workOrder.vehicleDataId}', // Placeholder
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const Text(
                          'B 1234 XYZ', // Hardcoded mockup
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Services
                const Text(
                  'Layanan:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF94A3B8),
                  ),
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
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Service ID: ${service.serviceId}', // Placeholder name
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF475569),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                          .format(workOrder.totalPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Upsell Badge mockup
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
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text = status.toUpperCase();

    // Simple mapping logic
    switch (status.toLowerCase()) {
      case 'queued':
        bgColor = const Color(0xFFDBEAFE);
        textColor = const Color(0xFF1E40AF);
        break;
      case 'washing':
        bgColor = const Color(0xFFFFEDD5);
        textColor = const Color(0xFF9A3412);
        break;
      case 'completed':
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        break;
      default:
        bgColor = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF475569);
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
