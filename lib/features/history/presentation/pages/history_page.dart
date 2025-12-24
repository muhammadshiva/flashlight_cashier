import 'dart:async';

import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../work_order/domain/entities/work_order.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Auto-refresh every 60 seconds (less frequent than queue)
    _refreshTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      context.read<HistoryBloc>().add(RefreshHistory());
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error600,
              action: SnackBarAction(
                label: 'Retry',
                textColor: AppColors.white,
                onPressed: () {
                  context.read<HistoryBloc>().add(LoadHistory());
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8FAFC),
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is HistoryLoaded) {
          return Scaffold(
            backgroundColor: Color(0xFFF8FAFC),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeaderSection(),
                  const SizedBox(height: 32),
                  _StatsAndFilterSection(state: state),
                  const SizedBox(height: 24),
                  _HistoryTable(
                    orders: state.filteredOrders,
                    customers: state.customers,
                    vehicles: state.vehicles,
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('Tidak ada data'));
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    'Riwayat Transaksi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B), // Slate-900
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis if text is too long
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B), // Slate-500
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.circle, size: 4, color: Color(0xFFCBD5E1)),
                const SizedBox(width: 8),
                Text(
                  'Riwayat',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.orangePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _StatsAndFilterSection extends StatelessWidget {
  final HistoryLoaded state;

  const _StatsAndFilterSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stats Cards
        Row(
          children: [
            _buildStatCard(
                'Total Transaksi',
                state.historyOrders.length.toString(),
                Icons.receipt_long,
                AppColors.dashboardBlue,
                AppColors.dashboardBlueLight),
            const SizedBox(width: 16),
            _buildStatCard(
                'Selesai',
                (state.statusCounts['completed'] ?? 0).toString(),
                Icons.check_circle,
                AppColors.success600,
                AppColors.success50),
            const SizedBox(width: 16),
            _buildStatCard(
                'Lunas',
                (state.statusCounts['paid'] ?? 0).toString(),
                Icons.monetization_on,
                AppColors.dashboardGreen,
                AppColors.dashboardGreenLight),
          ],
        ),
        const SizedBox(height: 24),
        // Search and Filter Bar
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)), // Slate-200
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC), // Slate-50
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Color(0xFF94A3B8), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                context
                                    .read<HistoryBloc>()
                                    .add(FilterHistory(searchQuery: value));
                              },
                              decoration: const InputDecoration(
                                hintText: 'Cari WO, Pelanggan, atau Plat Nomor',
                                border: InputBorder.none,
                                isDense: true,
                                hintStyle: TextStyle(
                                    color: Color(0xFF94A3B8), fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showFilterDialog(context, state);
                    },
                    icon: const Icon(Icons.filter_list, size: 18),
                    label: Text(state.selectedStatus == 'Semua'
                        ? 'Filter'
                        : state.selectedStatus),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B), // Slate-500
                      side: BorderSide(
                          color: state.selectedStatus == 'Semua'
                              ? const Color(0xFFE2E8F0)
                              : AppColors.orangePrimary),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF64748B), // Slate-500
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1E293B), // Slate-900
                    fontSize: 24, // Matches Product List
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context, HistoryLoaded state) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Filter Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterOption(context, dialogContext, 'Semua', state),
            _buildFilterOption(context, dialogContext, 'completed', state,
                label: 'Selesai'),
            _buildFilterOption(context, dialogContext, 'paid', state,
                label: 'Lunas'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, BuildContext dialogContext,
      String status, HistoryLoaded state,
      {String? label}) {
    final isSelected = state.selectedStatus == status;
    return ListTile(
      title: Text(label ?? status),
      selected: isSelected,
      selectedColor: AppColors.orangePrimary,
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        context.read<HistoryBloc>().add(FilterHistory(status: status));
        Navigator.pop(dialogContext);
      },
    );
  }
}

class _HistoryTable extends StatelessWidget {
  final List<WorkOrder> orders;
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;

  const _HistoryTable({
    required this.orders,
    required this.customers,
    required this.vehicles,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_outlined,
                size: 64,
                color: AppColors.textGray3.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tidak ada riwayat work order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.2), // WORK ORDER
          1: FlexColumnWidth(2), // CUSTOMER
          2: FlexColumnWidth(1.2), // TOTAL
          3: FlexColumnWidth(1), // STATUS
          4: FixedColumnWidth(100), // ACTION
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row
          const TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            children: [
              _HeaderCell('WORK ORDER'),
              _HeaderCell('PELANGGAN'),
              _HeaderCell('TOTAL'),
              _HeaderCell('STATUS'),
              _HeaderCell('ACTION', align: Alignment.centerRight),
            ],
          ),
          // Data Rows
          ...orders.map((order) {
            final customer = customers[order.customerId];
            final vehicle = vehicles[order.vehicleDataId];
            return TableRow(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFF1F5F9)),
                ),
              ),
              children: [
                _DataCell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${order.workOrderCode}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B), // Slate-900
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.completedAt != null
                            ? DateFormat('dd MMM yyyy, HH:mm')
                                .format(order.completedAt!)
                            : '-',
                        style: const TextStyle(
                          color: Color(0xFF94A3B8), // Slate-400
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _DataCell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            AppColors.orangePrimary.withOpacity(0.1),
                        child: Text(
                          (customer?.name ?? 'U').substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            color: AppColors.orangePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer?.name ?? 'Unknown',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E293B),
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (vehicle != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                '${vehicle.licensePlate} • ${vehicle.vehicleBrand}',
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _DataCell(
                  child: Text(
                    CurrencyFormatter.format(order.totalPrice),
                    style: const TextStyle(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                _DataCell(
                  child: _StatusBadge(status: order.status),
                ),
                _DataCell(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _ActionButton(
                      icon: Icons.visibility_outlined,
                      onTap: () {
                        context.go('/work-orders/${order.id}');
                      },
                      tooltip: 'Lihat Detail',
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final Alignment align;

  const _HeaderCell(this.label, {this.align = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B), // Slate-500
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final Widget child;

  const _DataCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: child,
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
    String label;

    final lowerStatus = status.toLowerCase();

    if (lowerStatus == 'paid') {
      bgColor = const Color(0xFFDCFCE7); // Green-100
      textColor = const Color(0xFF15803D); // Green-700
      label = 'Lunas';
    } else if (lowerStatus == 'completed') {
      bgColor = const Color(0xFFDBEAFE); // Blue-100
      textColor = const Color(0xFF1D4ED8); // Blue-700
      label = 'Selesai';
    } else {
      bgColor = const Color(0xFFF1F5F9); // Slate-100
      textColor = const Color(0xFF64748B); // Slate-500
      label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _ActionButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      color: const Color(0xFF64748B), // Slate-500
      tooltip: tooltip,
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(8),
        hoverColor: const Color(0xFFF1F5F9), // Slate-100
      ),
    );
  }
}
