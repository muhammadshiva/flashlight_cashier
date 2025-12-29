import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_dashboard_layout.dart';

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
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: CashierDashboardLayout(state: state),
      ),
    );
  }

  // ... (Greeting and Stats widgets remain unchanged)
}
