import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/shared/enum/payment_enum.dart';

class PaymentState extends Equatable {
  final PaymentMethodType selectedPaymentMethod;
  final String inputAmountStr;
  final String refNo;
  final String memberCode;
  final bool isPaymentSuccess;
  final bool isSubmitting;
  final int autoCloseTimer;
  final PaymentStatus status;
  final String? errorMessage;
  final bool isPrinting;

  const PaymentState({
    this.selectedPaymentMethod = PaymentMethodType.cash,
    this.inputAmountStr = '',
    this.refNo = '',
    this.memberCode = '',
    this.isPaymentSuccess = false,
    this.isSubmitting = false,
    this.autoCloseTimer = 5,
    this.status = PaymentStatus.initial,
    this.errorMessage,
    this.isPrinting = false,
  });

  PaymentState copyWith({
    PaymentMethodType? selectedPaymentMethod,
    String? inputAmountStr,
    String? refNo,
    String? memberCode,
    bool? isPaymentSuccess,
    bool? isSubmitting,
    int? autoCloseTimer,
    PaymentStatus? status,
    String? errorMessage,
    bool? isPrinting,
  }) {
    return PaymentState(
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      inputAmountStr: inputAmountStr ?? this.inputAmountStr,
      refNo: refNo ?? this.refNo,
      memberCode: memberCode ?? this.memberCode,
      isPaymentSuccess: isPaymentSuccess ?? this.isPaymentSuccess,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      autoCloseTimer: autoCloseTimer ?? this.autoCloseTimer,
      status: status ?? this.status,
      errorMessage: errorMessage,
      isPrinting: isPrinting ?? this.isPrinting,
    );
  }

  @override
  List<Object?> get props => [
        selectedPaymentMethod,
        inputAmountStr,
        refNo,
        memberCode,
        isPaymentSuccess,
        isSubmitting,
        autoCloseTimer,
        status,
        errorMessage,
        isPrinting,
      ];
}
