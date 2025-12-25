import 'dart:async';

import 'package:flashlight_pos/config/routes/app_routes.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/status_filter_bar.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Auto-refresh every 30 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      context.read<DashboardBloc>().add(RefreshDashboard());
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        // Show snackbar on error
        if (state is DashboardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  context.read<DashboardBloc>().add(LoadDashboardStats());
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardUpdating) {
          // Show previous data with loading overlay
          return Stack(
            children: [
              _buildDashboardContent(context, state.currentState),
              Container(
                color: Colors.black12,
                child: const Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Memperbarui status...'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is DashboardLoaded) {
          return _buildDashboardContent(context, state);
        }
        return const Center(child: Text('Tidak ada data'));
      },
    );
  }

  Widget _buildDashboardContent(BuildContext context, DashboardLoaded state) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<DashboardBloc>().add(RefreshDashboard());
          // Wait for state to update
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search and Action Bar
              Row(
                children: [
                  const Text(
                    'Work Orders',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  // Search Bar
                  Container(
                    width: 250,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context.read<DashboardBloc>().add(FilterWorkOrders(searchQuery: value));
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filter Button
                  OutlinedButton.icon(
                    onPressed: () => _showFilterDialog(context),
                    icon: const Icon(Icons.filter_list, size: 18),
                    label: const Text('By Status'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      fixedSize: const Size.fromHeight(44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Add Button
                  ElevatedButton.icon(
                    onPressed: () => context.push('/pos'),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('New Order'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      fixedSize: const Size.fromHeight(44),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Status Filter Chips
              const StatusFilterBar(),
              const SizedBox(height: 24),

              // Work Orders Table Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Work Orders',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    if (state.filteredOrders.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Tidak ada work order',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      _WorkOrderTable(
                        orders: state.filteredOrders,
                        customers: state.customers,
                        vehicles: state.vehicles,
                        onAction: (order, action) {
                          if (action == 'view' || action == 'edit') {
                            context.go(AppRoutes.workOrderDetail(order.id));
                          } else if (action == 'remove') {
                            // Implement remove logic or confirmation
                          }
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Greeting and Stats widgets remain unchanged)
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Filter Work Order'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter berdasarkan status:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Gunakan chip filter di bawah search bar untuk filter berdasarkan status.',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

class _WorkOrderTable extends StatelessWidget {
  final List<WorkOrder> orders;
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;
  final Function(WorkOrder, String) onAction;

  const _WorkOrderTable({
    required this.orders,
    required this.customers,
    required this.vehicles,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(60), // NO
          1: FlexColumnWidth(2.5), // WORK ORDER
          2: FlexColumnWidth(1.5), // CUSTOMER
          3: FlexColumnWidth(2), // VEHICLE
          4: FixedColumnWidth(130), // STATUS
          5: FixedColumnWidth(120), // TOTAL
          6: FixedColumnWidth(300), // ACTION (View, Edit, Remove)
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildHeaderRow(),
          ...orders.asMap().entries.map((entry) {
            final index = entry.key;
            final order = entry.value;
            final customer = customers[order.customerId];
            final vehicle = vehicles[order.vehicleDataId];
            return _buildRow(context, index, order, customer, vehicle);
          }),
        ],
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return const TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        _HeaderCell(text: 'NO'),
        _HeaderCell(text: 'WORK ORDER'),
        _HeaderCell(text: 'CUSTOMER'),
        _HeaderCell(text: 'VEHICLE'),
        _HeaderCell(text: 'STATUS'),
        _HeaderCell(text: 'TOTAL'),
        _HeaderCell(text: 'ACTION'),
      ],
    );
  }

  TableRow _buildRow(
      BuildContext context, int index, WorkOrder order, Customer? customer, Vehicle? vehicle) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        _DataCell(text: '${index + 1}'),
        _DataCell(text: order.workOrderCode, isBold: true),
        _DataCell(text: customer?.name ?? '-'),
        _DataCell(
            text: vehicle != null ? '${vehicle.vehicleBrand} - ${vehicle.licensePlate}' : '-'),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: _StatusBadge(status: order.status),
          ),
        ),
        _DataCell(text: '\$${order.totalPrice}'),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _ActionButton(
                        label: 'View',
                        icon: Icons.visibility_outlined,
                        onTap: () => onAction(order, 'view')),
                    const SizedBox(width: 8),
                    _ActionButton(
                        label: 'Edit',
                        icon: Icons.edit_outlined,
                        onTap: () => onAction(order, 'edit')),
                    const SizedBox(width: 8),
                    _ActionButton(
                        label: 'Remove',
                        icon: Icons.delete_outline,
                        color: const Color(0xFFEF4444),
                        onTap: () => onAction(order, 'remove')),
                  ],
                )))
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;

  const _HeaderCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF94A3B8),
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final bool isBold;

  const _DataCell({required this.text, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _ActionButton({required this.label, required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color ?? const Color(0xFF64748B)),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color ?? const Color(0xFF475569)))
          ],
        ),
      ),
    );
  }
}
