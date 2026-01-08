import 'dart:async';

import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      // Only listen when state changes to error (not on every rebuild)
      listenWhen: (previous, current) {
        // Only show snackbar when transitioning TO error state
        // or when the error message changes
        return current is DashboardError &&
            (previous is! DashboardError || previous.message != current.message);
      },
      listener: (context, state) {
        // Show snackbar on error
        if (state is DashboardError) {
          // Log technical error
          debugPrint('Dashboard Error: ${state.message}');

          final messenger = ScaffoldMessenger.of(context);

          // Clear any existing snackbars before showing new one
          messenger.clearSnackBars();

          messenger.showSnackBar(
            SnackBar(
              content: const Text('Gagal memuat data dashboard. Silakan coba lagi.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating, // Make it less intrusive
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  context.read<DashboardBloc>().add(LoadDashboardStats());
                },
              ),
            ),
          );

          // Failsafe: Explicitly hide snackbar after 3 seconds
          // This ensures it disappears even if the framework/scaffold state is complex
          Future.delayed(const Duration(seconds: 3), () {
            try {
              messenger.hideCurrentSnackBar();
            } catch (_) {
              // Ignore errors if widget is disposed
            }
          });
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
        // Fallback for other states (e.g. initial) - Show empty dashboard layout
        return _buildDashboardContent(
          context,
          const DashboardLoaded(
            totalOrders: 0,
            totalRevenue: 0,
            recentOrders: [],
          ),
        );
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
