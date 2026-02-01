import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/payment/payment_cubit.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/payment/payment_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_form_view.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_success_view.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';
import 'package:flashlight_pos/shared/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDialog extends StatefulWidget {
  final WorkOrder order;
  final Customer? customer;

  const PaymentDialog({
    super.key,
    required this.order,
    this.customer,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final TextEditingController _refNoController = TextEditingController();
  final ValueNotifier<bool> _isToastActiveNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _refNoController.dispose();
    _isToastActiveNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(order: widget.order),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listenWhen: (previous, current) =>
            previous.status != current.status || previous.autoCloseTimer != current.autoCloseTimer,
        listener: (context, state) {
          if (state.status == PaymentStatus.failure && state.errorMessage != null) {
            CustomSnackbar.showToast(
              context,
              message: state.errorMessage!,
              backgroundColor: AppColors.error5,
            );
            context.read<PaymentCubit>().resetStatus();

            // Handle toast active state if needed (though CustomSnackbar usually handles its own display time)
            _isToastActiveNotifier.value = true;
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) _isToastActiveNotifier.value = false;
            });
          }

          if (state.isPaymentSuccess && state.autoCloseTimer == 0) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<PaymentCubit>();
          final double taxAmount = widget.order.totalPrice * 0.11;
          final double grandTotal = widget.order.totalPrice + taxAmount;
          final double change = cubit.change;

          return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1100.w, maxHeight: 700.w),
                child: state.isPaymentSuccess
                    ? PaymentSuccessView(
                        grandTotal: grandTotal,
                        selectedPaymentMethod: state.selectedPaymentMethod,
                        refNo: state.refNo,
                        inputAmount: cubit.inputAmount,
                        change: change,
                        autoCloseTimer: state.autoCloseTimer,
                        onPrintReceipt: () => _handlePrintReceipt(context, cubit),
                        onConfirm: () => Navigator.pop(context),
                      )
                    : PaymentFormView(
                        selectedPaymentMethod: state.selectedPaymentMethod,
                        onPaymentMethodChanged: cubit.onChangePaymentMethod,
                        customer: widget.customer,
                        order: widget.order,
                        taxAmount: taxAmount,
                        grandTotal: grandTotal,
                        inputAmountStr: state.inputAmountStr,
                        onKeypadTap: cubit.onKeypadTap,
                        onSetAmount: cubit.setAmount,
                        isToastActiveNotifier: _isToastActiveNotifier,
                        onProcessPayment: cubit.processPayment,
                        refNoController: _refNoController
                          ..text = state.refNo
                          ..selection = TextSelection.collapsed(offset: state.refNo.length),
                        onClose: () => Navigator.pop(context),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handlePrintReceipt(BuildContext context, PaymentCubit cubit) {
    // Collect dependencies
    final settingsState = context.read<SettingsBloc>().state;
    Vehicle? vehicle;
    final dashboardState = context.read<DashboardBloc>().state;
    if (dashboardState is DashboardLoaded && widget.order.vehicleDataId.isNotEmpty) {
      vehicle = dashboardState.vehicles[widget.order.vehicleDataId];
    }

    cubit.printReceipt(
      receiptSettings: settingsState.receiptSettings,
      appSettings: settingsState.appSettings,
      vehicle: vehicle,
      customer: widget.customer,
    );
  }
}
