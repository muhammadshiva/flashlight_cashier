import 'dart:async';

import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/themes/app_colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';
import '../widgets/history_card.dart';

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
        // Show snackbar on error
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryLoaded) {
          return _buildHistoryContent(context, state);
        }
        return const Center(child: Text('Tidak ada data'));
      },
    );
  }

  Widget _buildHistoryContent(BuildContext context, HistoryLoaded state) {
    return Container(
      color: AppColors.dashboardBackground,
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HistoryBloc>().add(RefreshHistory());
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                'Riwayat Work Order',
                style: TextStyleConst.poppinsBold24
                    .copyWith(color: AppColors.blackText900),
              ),
              const SizedBox(height: 8),
              Text(
                'Daftar work order yang sudah selesai dan lunas',
                style: TextStyleConst.poppinsRegular14
                    .copyWith(color: AppColors.textGray3),
              ),
              const SizedBox(height: 24),

              // Search and Action Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<HistoryBloc>()
                            .add(FilterHistory(searchQuery: value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari WO, Nama, Plat Nomor, atau No. HP',
                        hintStyle: TextStyleConst.poppinsRegular14
                            .copyWith(color: AppColors.textGray3),
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.textGray3),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.borderGray),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.borderGray),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.primary600, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showFilterDialog(context, state);
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      foregroundColor: AppColors.blackText900,
                      side: const BorderSide(color: AppColors.borderGray),
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
                      backgroundColor: AppColors.dashboardBlue,
                      foregroundColor: AppColors.white,
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
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildFilterChip(
                    context,
                    'Semua',
                    state.statusCounts['Semua'] ?? 0,
                    isActive: state.selectedStatus == 'Semua',
                  ),
                  _buildFilterChip(
                    context,
                    'completed',
                    state.statusCounts['completed'] ?? 0,
                    isActive: state.selectedStatus == 'completed',
                    label: 'Selesai',
                  ),
                  _buildFilterChip(
                    context,
                    'paid',
                    state.statusCounts['paid'] ?? 0,
                    isActive: state.selectedStatus == 'paid',
                    label: 'Lunas',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Stats Summary
              Row(
                children: [
                  _buildStatCard(
                    icon: Icons.history,
                    label: 'Total Riwayat',
                    value: state.historyOrders.length.toString(),
                    color: AppColors.dashboardBlue,
                    bgColor: AppColors.dashboardBlueLight,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    icon: Icons.check_circle,
                    label: 'Selesai',
                    value: (state.statusCounts['completed'] ?? 0).toString(),
                    color: AppColors.success600,
                    bgColor: AppColors.success50,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    icon: Icons.payments,
                    label: 'Lunas',
                    value: (state.statusCounts['paid'] ?? 0).toString(),
                    color: AppColors.dashboardGreen,
                    bgColor: AppColors.dashboardGreenLight,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // History List
              if (state.filteredOrders.isEmpty)
                Center(
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
                        Text(
                          'Tidak ada riwayat work order',
                          style: TextStyleConst.poppinsSemiBold18
                              .copyWith(color: AppColors.textGray3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.searchQuery.isNotEmpty
                              ? 'Coba ubah kata kunci pencarian'
                              : 'Riwayat work order yang selesai akan muncul di sini',
                          style: TextStyleConst.poppinsRegular14
                              .copyWith(color: AppColors.textGray3),
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

                    return HistoryCard(
                      workOrder: order,
                      customer: customer,
                      vehicle: vehicle,
                      onTap: () {
                        context.go('/work-orders/${order.id}');
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

  Widget _buildFilterChip(
    BuildContext context,
    String status,
    int count, {
    bool isActive = false,
    String? label,
  }) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label ?? status,
            style: TextStyleConst.poppinsMedium14.copyWith(
              color: isActive ? AppColors.white : AppColors.textGray3,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.white.withValues(alpha: 0.2)
                  : AppColors.backgroundGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              count.toString(),
              style: TextStyleConst.poppinsBold12.copyWith(
                color: isActive ? AppColors.white : AppColors.textGray3,
              ),
            ),
          ),
        ],
      ),
      selected: isActive,
      onSelected: (selected) {
        context.read<HistoryBloc>().add(FilterHistory(status: status));
      },
      backgroundColor: AppColors.white,
      selectedColor: AppColors.dashboardBlue,
      checkmarkColor: AppColors.white,
      side: BorderSide(
        color: isActive ? AppColors.dashboardBlue : AppColors.borderGray,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGray, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.dashboardCardShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyleConst.poppinsRegular12
                        .copyWith(color: AppColors.textGray3),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyleConst.poppinsBold24
                        .copyWith(color: AppColors.blackText900),
                  ),
                ],
              ),
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
        title: Text(
          'Filter Riwayat',
          style: TextStyleConst.poppinsSemiBold18
              .copyWith(color: AppColors.blackText900),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter berdasarkan status:',
              style: TextStyleConst.poppinsMedium14
                  .copyWith(color: AppColors.blackText900),
            ),
            const SizedBox(height: 12),
            Text(
              'Gunakan chip filter di atas untuk memfilter berdasarkan status work order.',
              style: TextStyleConst.poppinsRegular12
                  .copyWith(color: AppColors.textGray3),
            ),
            const SizedBox(height: 16),
            Text(
              'Fitur filter tanggal akan segera hadir.',
              style: TextStyleConst.poppinsLight12
                  .copyWith(color: AppColors.textGray3),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Tutup',
              style: TextStyleConst.poppinsMedium14
                  .copyWith(color: AppColors.primary600),
            ),
          ),
        ],
      ),
    );
  }
}
