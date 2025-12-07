import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/status_filter_bar.dart';
import '../widgets/work_order_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardBloc>()..add(LoadDashboardStats()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is DashboardLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTabItem('Antrian', state.statusCounts['Semua'],
                          isActive: true),
                      const SizedBox(width: 24),
                      _buildTabItem('Riwayat', null),
                      const SizedBox(width: 24),
                      _buildTabItem('Laporan', null),
                    ],
                  ),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 24),

                  // Search and Action Bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            context
                                .read<DashboardBloc>()
                                .add(FilterWorkOrders(searchQuery: value));
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari WO, Plat Nomor, atau No. HP',
                            prefixIcon: const Icon(Icons.search,
                                color: Color(0xFF94A3B8)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list),
                        label: const Text('Filter'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          foregroundColor: const Color(0xFF1E293B),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('WO Baru (Non-Motor)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E293B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = state.filteredOrders[index];
                      final customerName =
                          state.customerNames[order.customerId];
                      final vehicleName =
                          state.vehicleNames[order.vehicleDataId];

                      return WorkOrderCard(
                        workOrder: order,
                        index: index,
                        customerName: customerName,
                        vehicleName: vehicleName,
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTabItem(String label, int? count, {bool isActive = false}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? const Color(0xFF1E293B)
                    : const Color(0xFF64748B),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFE2E8F0)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        if (isActive)
          Container(
            height: 2,
            width: 80, // rough width
            color: const Color(0xFF1E293B),
          ),
      ],
    );
  }
}
