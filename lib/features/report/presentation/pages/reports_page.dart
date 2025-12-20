import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        appBar: AppBar(title: const Text('Laporan')),
        body: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ReportsLoaded) {
              final sortedDates = state.dailyRevenue.keys.toList()..sort((a, b) => b.compareTo(a));

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                            child: _buildSummaryCard('Cars Washed',
                                state.totalCarsProcessed.toString(), Icons.directions_car)),
                        const SizedBox(width: 16),
                        // You can add more summary cards here
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text('Pendapatan per Layanan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Card(
                      child: Column(
                        children: state.serviceRevenue.entries.map((e) {
                          return ListTile(
                            title: Text(e.key),
                            trailing: Text(CurrencyFormatter.format(e.value)),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text('Pendapatan Harian',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Card(
                      child: Column(
                        children: sortedDates.map((date) {
                          return ListTile(
                            title: Text(DateFormat('EEEE, d MMM y').format(date)),
                            trailing: Text(CurrencyFormatter.format(state.dailyRevenue[date]!)),
                          );
                        }).toList(),
                      ),
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

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
