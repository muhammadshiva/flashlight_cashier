import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/dashboard/presentation/bloc/payment/payment_state.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/entities/receipt_settings.dart';
import 'package:flashlight_pos/features/settings/domain/services/receipt_generator.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final WorkOrder order;
  Timer? _timer;

  PaymentCubit({required this.order}) : super(const PaymentState());

  double get _taxAmount => order.totalPrice * 0.11;
  double get grandTotal => order.totalPrice + _taxAmount;
  double get inputAmount => double.tryParse(state.inputAmountStr) ?? 0;
  double get change => inputAmount > grandTotal ? inputAmount - grandTotal : 0;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void onChangePaymentMethod(PaymentMethodType method) {
    if (state.isPaymentSuccess) return;

    // When switching to Card or QR, auto-set input amount to exact total
    String newInputAmount = state.inputAmountStr;
    if (!method.isCash) {
      newInputAmount = grandTotal.toInt().toString();
    }

    emit(state.copyWith(
      selectedPaymentMethod: method,
      inputAmountStr: !method.isCash ? grandTotal.toInt().toString() : newInputAmount,
    ));
  }

  void updateRefNo(String value) {
    emit(state.copyWith(refNo: value));
  }

  void onKeypadTap(String value) {
    if (state.isPaymentSuccess) return;

    String current = state.inputAmountStr;
    if (value == 'DEL') {
      if (current.isNotEmpty) {
        current = current.substring(0, current.length - 1);
      }
    } else if (value == 'CLEAR') {
      current = '';
    } else {
      if (current.length < 12) {
        current += value;
      }
    }
    emit(state.copyWith(inputAmountStr: current));
  }

  void setAmount(int amount) {
    if (state.isPaymentSuccess) return;
    emit(state.copyWith(inputAmountStr: amount.toString()));
  }

  void processPayment() {
    // For Cash
    if (state.selectedPaymentMethod.isCash) {
      if (inputAmount < grandTotal) {
        emit(state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: 'Insufficient amount',
        ));
        // Reset status after a bit so toast can show again if needed?
        // Or just let UI handle it. UI consumes the state.

        // We clear error logic in UI listener usually.
        // But to allow re-trigger, we might emit initial status shortly after.
        return;
      }
    }

    // Success
    emit(state.copyWith(
      isPaymentSuccess: true,
      status: PaymentStatus.success,
      // Ensure input amount is set to full if it was external payment
      inputAmountStr: !state.selectedPaymentMethod.isCash
          ? grandTotal.toInt().toString()
          : state.inputAmountStr,
    ));

    _startAutoCloseTimer();
  }

  void _startAutoCloseTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.autoCloseTimer == 0) {
        timer.cancel();
        // UI should listen to this and pop
      } else {
        emit(state.copyWith(autoCloseTimer: state.autoCloseTimer - 1));
      }
    });
  }

  Future<void> printReceipt({
    required ReceiptSettings? receiptSettings,
    required AppSettings? appSettings,
    required Vehicle? vehicle,
    required Customer? customer,
  }) async {
    if (receiptSettings == null || appSettings == null) {
      emit(state.copyWith(
        status: PaymentStatus.failure,
        errorMessage: 'Settings not loaded',
      ));
      return;
    }

    emit(state.copyWith(isPrinting: true));

    try {
      final bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (!isConnected) {
        emit(state.copyWith(
          isPrinting: false,
          status: PaymentStatus.failure,
          errorMessage: 'Printer not connected. Please connect in Settings.',
        ));
        return;
      }

      // Construct Receipt Order
      String paymentMethod = 'CASH';
      if (state.selectedPaymentMethod == PaymentMethodType.card) paymentMethod = 'CARD';
      if (state.selectedPaymentMethod == PaymentMethodType.qris) paymentMethod = 'QRIS';

      int paidAmount = inputAmount.toInt();
      if (state.selectedPaymentMethod != PaymentMethodType.cash) {
        paidAmount = grandTotal.toInt();
      }

      final receiptOrder = WorkOrder(
        id: order.id,
        workOrderCode: order.workOrderCode,
        customerId: order.customerId,
        vehicleDataId: order.vehicleDataId,
        queueNumber: order.queueNumber,
        estimatedTime: order.estimatedTime,
        status: order.status,
        paymentStatus: 'paid',
        paymentMethod: paymentMethod,
        paidAmount: paidAmount,
        totalPrice: order.totalPrice,
        services: order.services,
        products: order.products,
        createdAt: order.createdAt,
        updatedAt: DateTime.now(),
        completedAt: DateTime.now(),
      );

      final generator = ReceiptGenerator();
      final bytes = await generator.generateReceiptBytes(
        order: receiptOrder,
        settings: receiptSettings,
        appSettings: appSettings,
        customer: customer,
        vehicle: vehicle,
      );

      await PrintBluetoothThermal.writeBytes(bytes);

      emit(state.copyWith(isPrinting: false));
    } catch (e) {
      emit(state.copyWith(
        isPrinting: false,
        status: PaymentStatus.failure,
        errorMessage: 'Failed to print: $e',
      ));
    }
  }

  void resetStatus() {
    emit(state.copyWith(status: PaymentStatus.initial, errorMessage: null));
  }
}
