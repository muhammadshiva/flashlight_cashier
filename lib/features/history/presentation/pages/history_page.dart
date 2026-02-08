import 'dart:async';

import 'package:flashlight_pos/shared/widgets/custom_loading.dart';
import 'package:flashlight_pos/shared/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/app_colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';
import '../widgets/history_header.dart';
import '../widgets/history_pagination.dart';
import '../widgets/history_stats.dart';
import '../widgets/history_table.dart';

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
          CustomSnackbar.showToast(
            context,
            message: state.message,
            backgroundColor: AppColors.error5,
            onRetry: () {
              context.read<HistoryBloc>().add(LoadHistory());
            },
          );
        }
      },
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Scaffold(
            backgroundColor: AppColors.slate50,
            body: CustomLoading(),
          );
        } else if (state is HistoryLoaded) {
          return Scaffold(
            backgroundColor: AppColors.slate50,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.fromLTRB(32.w, 16.w, 32.w, 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HistoryHeader(state: state),
                  SizedBox(height: 32.w),
                  HistoryStats(state: state),
                  SizedBox(height: 24.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.slate200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Divider(height: 1.w, color: AppColors.slate100),
                          Expanded(
                            child: HistoryTable(
                              orders: state.displayedOrders,
                              customers: state.customers,
                              vehicles: state.vehicles,
                            ),
                          ),
                          const HistoryPagination(),
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
