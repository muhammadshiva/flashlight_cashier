import 'dart:async';

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
            backgroundColor: const Color(0xFFF8FAFC),
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderWithSearchAndFilter(state: state),
                  const SizedBox(height: 32),
                  _StatsSection(state: state),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
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
                      child: Column(
                        children: [
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          Expanded(
                            child: _HistoryTable(
                              orders: state.displayedOrders,
                              customers: state.customers,
                              vehicles: state.vehicles,
                            ),
                          ),
                          const _PaginationSection(),
                        ],
                      ),
                    ),
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

class _HeaderWithSearchAndFilter extends StatelessWidget {
  final HistoryLoaded state;

  const _HeaderWithSearchAndFilter({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Transaksi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.circle, size: 4, color: Color(0xFFCBD5E1)),
                SizedBox(width: 8),
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
        Row(
          children: [
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context.read<HistoryBloc>().add(FilterHistory(searchQuery: value));
                      },
                      decoration: const InputDecoration(
                        hintText: 'Cari WO, Pelanggan, Plat...',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () {
                _showFilterDialog(context, state);
              },
              icon: const Icon(Icons.filter_list, size: 18),
              label: Text(state.selectedStatus == 'Semua' ? 'Filter' : state.selectedStatus),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF64748B),
                side: BorderSide(
                    color: state.selectedStatus == 'Semua'
                        ? const Color(0xFFE2E8F0)
                        : AppColors.orangePrimary),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ],
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
            _buildFilterOption(context, dialogContext, 'completed', state, label: 'Selesai'),
            _buildFilterOption(context, dialogContext, 'paid', state, label: 'Lunas'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(
      BuildContext context, BuildContext dialogContext, String status, HistoryLoaded state,
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

class _StatsSection extends StatelessWidget {
  final HistoryLoaded state;

  const _StatsSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard('Total Transaksi', state.historyOrders.length.toString(), Icons.receipt_long,
            AppColors.dashboardBlue, AppColors.dashboardBlueLight),
        const SizedBox(width: 16),
        _buildStatCard('Selesai', (state.statusCounts['completed'] ?? 0).toString(),
            Icons.check_circle, AppColors.success600, AppColors.success50),
        const SizedBox(width: 16),
        _buildStatCard('Lunas', (state.statusCounts['paid'] ?? 0).toString(), Icons.monetization_on,
            AppColors.dashboardGreen, AppColors.dashboardGreenLight),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, Color bgColor) {
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
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 24,
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

    return Column(
      children: [
        // Sticky Header
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1),
            4: FixedColumnWidth(100),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
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
          ],
        ),
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1.2),
                3: FlexColumnWidth(1),
                4: FixedColumnWidth(100),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
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
                                color: Color(0xFF1E293B),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              order.completedAt != null
                                  ? DateFormat('dd MMM yyyy, HH:mm').format(order.completedAt!)
                                  : '-',
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
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
                              backgroundColor: AppColors.orangePrimary.withOpacity(0.1),
                              child: Text(
                                (customer?.name ?? 'U').substring(0, 1).toUpperCase(),
                                style: const TextStyle(
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
          ),
        ),
      ],
    );
  }
}

class _PaginationSection extends StatelessWidget {
  const _PaginationSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is! HistoryLoaded) return const SizedBox.shrink();

        final currentPage = state.currentPage;
        final itemsPerPage = state.itemsPerPage;
        final totalItems = state.totalItems;
        final totalPages = (totalItems / itemsPerPage).ceil();

        final startItem = (currentPage - 1) * itemsPerPage + 1;
        final endItem = (startItem + state.displayedOrders.length - 1);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('View', style: TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Text('$itemsPerPage', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('entry per page', style: TextStyle(color: Color(0xFF64748B))),
                ],
              ),
              Row(
                children: [
                  Text('Showing $startItem-$endItem of $totalItems entries',
                      style: const TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(width: 24),
                  IconButton(
                      onPressed: currentPage > 1
                          ? () => context.read<HistoryBloc>().add(ChangePageEvent(currentPage - 1))
                          : null,
                      icon: Icon(Icons.chevron_left,
                          color:
                              currentPage > 1 ? const Color(0xFF64748B) : const Color(0xFFCBD5E1))),
                  ...List.generate(totalPages, (index) {
                    final page = index + 1;
                    if (totalPages > 7 &&
                        (page > 2 &&
                            page < totalPages - 1 &&
                            (page < currentPage - 1 || page > currentPage + 1))) {
                      return page == currentPage - 2 || page == currentPage + 2
                          ? const Text('...', style: TextStyle(color: Color(0xFF64748B)))
                          : const SizedBox.shrink();
                    }
                    return _buildPageNumber(context, page, isActive: page == currentPage);
                  }),
                  IconButton(
                      onPressed: currentPage < totalPages
                          ? () => context.read<HistoryBloc>().add(ChangePageEvent(currentPage + 1))
                          : null,
                      icon: Icon(Icons.chevron_right,
                          color: currentPage < totalPages
                              ? const Color(0xFF64748B)
                              : const Color(0xFFCBD5E1))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageNumber(BuildContext context, int number, {required bool isActive}) {
    return InkWell(
      onTap: () => context.read<HistoryBloc>().add(ChangePageEvent(number)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.orangePrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
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
            color: Color(0xFF64748B),
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
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF15803D);
      label = 'Lunas';
    } else if (lowerStatus == 'completed') {
      bgColor = const Color(0xFFDBEAFE);
      textColor = const Color(0xFF1D4ED8);
      label = 'Selesai';
    } else {
      bgColor = const Color(0xFFF1F5F9);
      textColor = const Color(0xFF64748B);
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
      color: const Color(0xFF64748B),
      tooltip: tooltip,
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(8),
        hoverColor: const Color(0xFFF1F5F9),
      ),
    );
  }
}
