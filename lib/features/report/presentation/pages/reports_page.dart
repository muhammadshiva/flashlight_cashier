import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../injection_container.dart';
import '../bloc/reports_bloc.dart';
import '../bloc/reports_event.dart';
import '../bloc/reports_state.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReportsBloc>()..add(LoadReports()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC), // Slate-50
        body: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state is ReportsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error600,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error600,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ReportsLoaded) {
              final sortedDates = state.dailyRevenue.keys.toList()..sort((a, b) => b.compareTo(a));

              return SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeaderSection(),
                    const SizedBox(height: 32),

                    // Summary Cards
                    Row(
                      children: [
                        _buildSummaryCard(
                          'Total Motor Dicuci',
                          state.totalCarsProcessed.toString(),
                          Icons.directions_car,
                          AppColors.dashboardBlue,
                          AppColors.dashboardBlueLight,
                        ),
                        const SizedBox(width: 24),
                        _buildSummaryCard(
                          'Total Pendapatan',
                          CurrencyFormatter.format(
                            state.dailyRevenue.values.fold(0, (sum, amount) => sum + amount),
                          ),
                          Icons.attach_money,
                          AppColors.dashboardGreen,
                          AppColors.dashboardGreenLight,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Tables
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Revenue Table
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pendapatan per Layanan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _ServiceRevenueTable(serviceRevenue: state.serviceRevenue),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Daily Revenue Table
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pendapatan Harian',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _DailyRevenueTable(
                                sortedDates: sortedDates,
                                dailyRevenue: state.dailyRevenue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
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

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Laporan Penjualan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B), // Slate-900
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B), // Slate-500
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.circle, size: 4, color: Color(0xFFCBD5E1)),
            SizedBox(width: 8),
            Text(
              'Laporan',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.orangePrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceRevenueTable extends StatelessWidget {
  final Map<String, int> serviceRevenue;

  const _ServiceRevenueTable({required this.serviceRevenue});

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          // Sticky Header
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                ),
                children: [
                  _HeaderCell('LAYANAN'),
                  _HeaderCell('PENDAPATAN', align: Alignment.centerRight),
                ],
              ),
            ],
          ),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.5),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  ...serviceRevenue.entries.map((entry) {
                    return TableRow(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                      ),
                      children: [
                        _DataCell(
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E293B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        _DataCell(
                          align: Alignment.centerRight,
                          child: Text(
                            CurrencyFormatter.format(entry.value),
                            style: const TextStyle(
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.w600,
                              color: AppColors.dashboardGreen,
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
      ),
    );
  }
}

class _DailyRevenueTable extends StatelessWidget {
  final List<DateTime> sortedDates;
  final Map<DateTime, int> dailyRevenue;

  const _DailyRevenueTable({
    required this.sortedDates,
    required this.dailyRevenue,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          // Sticky Header
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                ),
                children: [
                  _HeaderCell('TANGGAL'),
                  _HeaderCell('PENDAPATAN', align: Alignment.centerRight),
                ],
              ),
            ],
          ),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.5),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  ...sortedDates.map((date) {
                    final revenue = dailyRevenue[date]!;
                    return TableRow(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                      ),
                      children: [
                        _DataCell(
                          child: Text(
                            DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E293B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        _DataCell(
                          align: Alignment.centerRight,
                          child: Text(
                            CurrencyFormatter.format(revenue),
                            style: const TextStyle(
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.w600,
                              color: AppColors.dashboardBlue,
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
  final Alignment align;

  const _DataCell({
    required this.child,
    this.align = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Align(
        alignment: align,
        child: child,
      ),
    );
  }
}
