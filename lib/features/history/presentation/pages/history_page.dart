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

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: _onStateChanged,
      builder: (context, state) {
        if (state is HistoryLoading) return _buildLoading();
        if (state is HistoryLoaded) return _buildLoaded(state);
        return _buildEmpty();
      },
    );
  }

  void _onStateChanged(BuildContext context, HistoryState state) {
    if (state is HistoryError) {
      CustomSnackbar.showToast(
        context,
        message: state.message,
        backgroundColor: AppColors.error5,
        onRetry: () => context.read<HistoryBloc>().add(LoadHistory()),
      );
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      backgroundColor: AppColors.slate50,
      body: CustomLoading(),
    );
  }

  Widget _buildLoaded(HistoryLoaded state) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(32.w, 16.w, 32.w, 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HistoryHeader(state: state),
            SizedBox(height: 16.w),
            HistoryStats(state: state),
            SizedBox(height: 24.w),
            Expanded(child: _buildTableCard(state)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCard(HistoryLoaded state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
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
    );
  }

  Widget _buildEmpty() {
    return const Center(child: Text('Tidak ada data'));
  }
}
