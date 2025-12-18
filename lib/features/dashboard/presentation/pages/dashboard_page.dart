import 'dart:async';

import 'package:flashlight_pos/config/routes/app_routes.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/themes/app_colors.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/status_filter_bar.dart';
import '../widgets/work_order_card.dart';

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
      color: AppColors.dashboardBackground,
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
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context.read<DashboardBloc>().add(FilterWorkOrders(searchQuery: value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari WO, Nama, Plat Nomor, atau No. HP',
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Show filter dialog
                      _showFilterDialog(context);
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      foregroundColor: const Color(0xFF1E293B),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/pos');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('WO Baru'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E293B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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

              // Work Orders List
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
                        const SizedBox(height: 8),
                        Text(
                          state.searchQuery.isNotEmpty
                              ? 'Coba ubah kata kunci pencarian'
                              : 'Buat work order baru untuk memulai',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = state.filteredOrders[index];
                    final customer = state.customers[order.customerId];
                    final vehicle = state.vehicles[order.vehicleDataId];

                    return WorkOrderCard(
                      workOrder: order,
                      index: index,
                      customer: customer,
                      vehicle: vehicle,
                      onActionPressed: () {
                        _handleWorkOrderAction(context, order);
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleWorkOrderAction(BuildContext context, WorkOrder order) {
    final currentStatus = order.status.toLowerCase();
    String newStatus;

    switch (currentStatus) {
      case 'queued':
        newStatus = 'washing';
        break;
      case 'washing':
        newStatus = 'drying';
        break;
      case 'drying':
        newStatus = 'inspection';
        break;
      case 'inspection':
        newStatus = 'completed';
        break;
      case 'completed':
        // Navigate to payment page
        context.go(AppRoutes.workOrderDetail(order.id));
        return;
      case 'paid':
        // Navigate to detail page
        context.go(AppRoutes.workOrderDetail(order.id));
        return;
      default:
        return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text(
          'Ubah status work order ${order.workOrderCode} ke ${_getStatusLabel(newStatus)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<DashboardBloc>().add(
                    UpdateWorkOrderStatusEvent(
                      workOrderId: order.id,
                      newStatus: newStatus,
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
            ),
            child: const Text('Ya, Lanjutkan'),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'queued':
        return 'Antri';
      case 'washing':
        return 'Sedang Cuci';
      case 'drying':
        return 'Sedang Kering';
      case 'inspection':
        return 'Inspeksi';
      case 'completed':
        return 'Selesai';
      case 'paid':
        return 'Lunas';
      default:
        return status;
    }
  }

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
