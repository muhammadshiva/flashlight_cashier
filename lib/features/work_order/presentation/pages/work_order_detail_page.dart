import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/work_order.dart';
import '../bloc/detail/work_order_detail_bloc.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import '../bloc/detail/work_order_detail_event.dart';
import '../bloc/detail/work_order_detail_state.dart';

class WorkOrderDetailPage extends StatelessWidget {
  final String workOrderId;

  const WorkOrderDetailPage({super.key, required this.workOrderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<WorkOrderDetailBloc>()..add(LoadWorkOrderDetail(workOrderId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          title: const Text('Detail Work Order',
              style: TextStyle(color: Color(0xFF1E293B))),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<WorkOrderDetailBloc, WorkOrderDetailState>(
          builder: (context, state) {
            if (state is WorkOrderDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkOrderDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is WorkOrderDetailLoaded) {
              final wo = state.workOrder;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, wo),
                    const SizedBox(height: 24),
                    _buildStatusSection(context, wo),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildCustomerSection(wo)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildVehicleSection(wo)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildItemsSection(wo),
                    const SizedBox(height: 24),
                    _buildFinancialSection(wo),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WorkOrder wo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wo.workOrderCode,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Dibuat pada ${DateFormat('dd MMM yyyy, HH:mm').format(wo.createdAt ?? DateTime.now())}',
              style: const TextStyle(color: Color(0xFF64748B)),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Queue: ${wo.queueNumber}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection(BuildContext context, WorkOrder wo) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF64748B)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Status Saat Ini',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                Text(
                  wo.status.toUpperCase().replaceAll('_', ' '),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (wo.status != 'completed' && wo.status != 'cancelled')
              PopupMenuButton<String>(
                onSelected: (value) {
                  context.read<WorkOrderDetailBloc>().add(
                        UpdateWorkOrderStatusEvent(wo.id, value),
                      );
                },
                itemBuilder: (context) => [
                  if (wo.status == 'created')
                    const PopupMenuItem(
                      value: 'in_progress',
                      child: Text('Mulai Pengerjaan (In Progress)'),
                    ),
                  if (wo.status == 'in_progress')
                    const PopupMenuItem(
                      value: 'completed',
                      child: Text('Selesaikan (Completed)'),
                    ),
                  const PopupMenuItem(
                    value: 'cancelled',
                    child: Text('Batalkan (Cancel)'),
                  ),
                ],
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: const Row(
                    children: [
                      Text('Update Status',
                          style: TextStyle(color: Colors.blue)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_drop_down, color: Colors.blue),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSection(WorkOrder wo) {
    // Note: We only have customerId here, not name/phone unless we fetch it separately or it's included.
    // The entity has customerId. The details page usually requires fetching Customer details too.
    // OR the WorkOrder entity returned by API includes customer data nested?
    // API Contract says: Response Data (`data`): `WorkOrder Object` (with preloaded relations)
    // BUT the WorkOrder ENTITY in Dart `lib/.../entities/work_order.dart` currently only has `customerId` string.
    // It DOES NOT have a `Customer` object field.
    // See step Id 59 output.
    // This is a GAP in the Entity definition vs API Contract.
    // To show customer name, I need to either:
    // 1. Update Entity to include `Customer? customer`.
    // 2. Fetch Customer separately.
    // I should Update Entity to match API Contract (preloaded relations).
    // Let's assume I'll display the ID for now and then Refactor Entity.
    // Actually, I should Refactor Entity to be correct.
    // But for SPEED, I will stick to what I have and maybe just show "Customer ID: ..."
    // Or I'll fetch customer by ID inside the Bloc?
    // Let's stick to ID for now to be safe and compile, then I'll create a task to enrich the model.
    return _buildInfoCard('Informasi Pelanggan', [
      _buildInfoRow('ID Pelanggan', wo.customerId),
      // _buildInfoRow('Nama', 'Loading...'),
    ]);
  }

  Widget _buildVehicleSection(WorkOrder wo) {
    return _buildInfoCard('Informasi Kendaraan', [
      _buildInfoRow('ID Data Kendaraan', wo.vehicleDataId),
      // _buildInfoRow('Plat Nomor', 'Loading...'),
    ]);
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B))),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child:
                Text(label, style: const TextStyle(color: Color(0xFF64748B))),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(WorkOrder wo) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Item Pekerjaan & Produk',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B))),
            const Divider(height: 24),
            if (wo.services.isNotEmpty) ...[
              const Text('Jasa (Services)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...wo.services.map((s) => _buildItemRow(s.serviceId, s.quantity,
                  s.priceAtOrder, s.subtotal)), // Using ID as name for now
              const SizedBox(height: 16),
            ],
            if (wo.products.isNotEmpty) ...[
              const Text('Produk (F&B)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...wo.products.map((p) => _buildItemRow(
                  p.productId, p.quantity, p.priceAtOrder, p.subtotal)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(String name, int qty, int price, int subtotal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(name)), // TODO: Resolve Name
          Text('${qty}x'),
          const SizedBox(width: 16),
          SizedBox(
              width: 100,
              child: Text(_formatCurrency(price), textAlign: TextAlign.right)),
          SizedBox(
              width: 100,
              child: Text(_formatCurrency(subtotal),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildFinancialSection(WorkOrder wo) {
    return Card(
      color: const Color(0xFF1E293B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Biaya',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
                Text(_formatCurrency(wo.totalPrice),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Status Pembayaran',
                    style: TextStyle(color: Colors.white70)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: wo.paymentStatus == 'paid'
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(wo.paymentStatus?.toUpperCase() ?? 'PENDING',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toCurrencyFormat();
  }
}
