import 'dart:async';

import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/cashier_dashboard_layout/cashier_dashboard_layout.dart';
import 'package:flashlight_pos/shared/widgets/custom_loading.dart';
import 'package:flashlight_pos/shared/widgets/custom_snackbar.dart';
import 'package:flashlight_pos/shared/widgets/loading_overlay_widget.dart';
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
    // Only listen when state changes to error (not on every rebuild)
    return BlocConsumer<DashboardBloc, DashboardState>(
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

          CustomSnackbar.show(
            context,
            message: 'Gagal memuat data dashboard. Silakan coba lagi.',
            onRetry: () {
              context.read<DashboardBloc>().add(LoadDashboardStats());
            },
          );
        }
      },
      builder: (context, state) {
        if (state is DashboardLoading) return const CustomLoading();

        // Show previous data with loading overlay
        if (state is DashboardUpdating) {
          return LoadingOverlayWidget(
            isVisible: true,
            message: 'Memperbarui status...',
            child: _buildDashboardContent(context, state.currentState),
          );
        }

        if (state is DashboardLoaded) return _buildDashboardContent(context, state);

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
      child: CashierDashboardLayout(state: state),
    );
  }
}
