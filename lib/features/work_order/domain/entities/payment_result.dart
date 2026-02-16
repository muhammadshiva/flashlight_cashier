import 'package:equatable/equatable.dart';

class PaymentResult extends Equatable {
  final String id;
  final String workOrderId;
  final String paymentMethod;
  final int paidAmount;
  final int totalAmount;
  final int taxAmount;
  final int changeAmount;
  final String paymentStatus;
  final DateTime? paidAt;

  const PaymentResult({
    required this.id,
    required this.workOrderId,
    required this.paymentMethod,
    required this.paidAmount,
    required this.totalAmount,
    required this.taxAmount,
    this.changeAmount = 0,
    required this.paymentStatus,
    this.paidAt,
  });

  @override
  List<Object?> get props => [
        id,
        workOrderId,
        paymentMethod,
        paidAmount,
        totalAmount,
        taxAmount,
        changeAmount,
        paymentStatus,
        paidAt,
      ];
}
