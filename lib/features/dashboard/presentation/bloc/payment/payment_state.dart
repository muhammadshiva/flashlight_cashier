import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';

class PaymentState extends Equatable {
  final PaymentMethodType selectedPaymentMethod;
  final String inputAmountStr;
  final String refNo;
  final bool isPaymentSuccess;
  final int autoCloseTimer;
  final PaymentStatus status;
  final String? errorMessage;
  final bool isPrinting;

  const PaymentState({
    this.selectedPaymentMethod = PaymentMethodType.cash,
    this.inputAmountStr = '',
    this.refNo = '',
    this.isPaymentSuccess = false,
    this.autoCloseTimer = 5,
    this.status = PaymentStatus.initial,
    this.errorMessage,
    this.isPrinting = false,
  });

  PaymentState copyWith({
    PaymentMethodType? selectedPaymentMethod,
    String? inputAmountStr,
    String? refNo,
    bool? isPaymentSuccess,
    int? autoCloseTimer,
    PaymentStatus? status,
    String? errorMessage,
    bool? isPrinting,
  }) {
    return PaymentState(
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      inputAmountStr: inputAmountStr ?? this.inputAmountStr,
      refNo: refNo ?? this.refNo,
      isPaymentSuccess: isPaymentSuccess ?? this.isPaymentSuccess,
      autoCloseTimer: autoCloseTimer ?? this.autoCloseTimer,
      status: status ?? this.status,
      errorMessage: errorMessage, // Reset error on change generally, but custom here
      isPrinting: isPrinting ?? this.isPrinting,
    );
  }

  @override
  List<Object?> get props => [
        selectedPaymentMethod,
        inputAmountStr,
        refNo,
        isPaymentSuccess,
        autoCloseTimer,
        status,
        errorMessage,
        isPrinting,
      ];
}
