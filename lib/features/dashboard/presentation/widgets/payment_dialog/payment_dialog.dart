import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/payment/payment_cubit.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/payment/payment_state.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_form_view.dart';
import 'package:flashlight_pos/features/dashboard/presentation/widgets/payment_dialog/components/payment_success_view.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flashlight_pos/features/work_order/domain/usecases/process_payment.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

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
  final TextEditingController _memberCodeController = TextEditingController();

  @override
  void dispose() {
    _refNoController.dispose();
    _memberCodeController.dispose();
    super.dispose();
  }

  void _softRefreshAndClose(BuildContext context) {
    context.read<DashboardBloc>().add(ClearSelectedOrder());
    context.read<DashboardBloc>().add(RefreshDashboard());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        order: widget.order,
        processPaymentUseCase: GetIt.instance<ProcessPayment>(),
      ),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listenWhen: (previous, current) =>
            previous.status != current.status || previous.autoCloseTimer != current.autoCloseTimer,
        listener: (context, state) {
          if (state.status == PaymentStatus.failure && state.errorMessage != null) {
            context.read<PaymentCubit>().resetStatus();
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                title: Row(
                  children: [
                    Icon(Icons.error_outline,
                        color: AppColors.error5, size: 24.w),
                    SizedBox(width: 12.w),
                    Text('Payment Failed',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
                content: Text(
                  state.errorMessage!,
                  style: TextStyle(
                      fontSize: 14.sp, color: AppColors.slate500),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          // Auto-close: soft refresh dashboard before popping
          if (state.isPaymentSuccess && state.autoCloseTimer == 0) {
            _softRefreshAndClose(context);
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
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
                        onConfirm: () => _softRefreshAndClose(context),
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
                        onProcessPayment: cubit.processPayment,
                        isSubmitting: state.isSubmitting,
                        refNoController: _refNoController
                          ..text = state.refNo
                          ..selection = TextSelection.collapsed(offset: state.refNo.length),
                        memberCodeController: _memberCodeController
                          ..text = state.memberCode
                          ..selection = TextSelection.collapsed(offset: state.memberCode.length),
                        onMemberCodeChanged: cubit.updateMemberCode,
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
