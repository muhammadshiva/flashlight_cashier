import 'package:equatable/equatable.dart';

import '../../domain/entities/payment_result.dart';

/// Model for payment POST request body.
class PaymentRequestModel extends Equatable {
  final String paymentMethod;
  final int paidAmount;
  final int totalAmount;
  final int taxAmount;
  final int changeAmount;
  final String? referenceNumber;
  final String? memberCode;

  const PaymentRequestModel({
    required this.paymentMethod,
    required this.paidAmount,
    required this.totalAmount,
    required this.taxAmount,
    this.changeAmount = 0,
    this.referenceNumber,
    this.memberCode,
  });

  Map<String, dynamic> toJson() => {
        'paymentMethod': paymentMethod,
        'paidAmount': paidAmount,
        'totalAmount': totalAmount,
        'taxAmount': taxAmount,
        'changeAmount': changeAmount,
        if (referenceNumber != null) 'referenceNumber': referenceNumber,
        if (memberCode != null) 'memberCode': memberCode,
      };

  @override
  List<Object?> get props => [
        paymentMethod,
        paidAmount,
        totalAmount,
        taxAmount,
        changeAmount,
        referenceNumber,
        memberCode,
      ];
}

/// Model for payment API response (inside data envelope).
class PaymentResponseModel extends Equatable {
  final String id;
  final String workOrderId;
  final String paymentMethod;
  final int paidAmount;
  final int totalAmount;
  final int taxAmount;
  final int changeAmount;
  final String? referenceNumber;
  final String? memberCode;
  final String paymentStatus;
  final DateTime? paidAt;

  const PaymentResponseModel({
    required this.id,
    required this.workOrderId,
    required this.paymentMethod,
    required this.paidAmount,
    required this.totalAmount,
    required this.taxAmount,
    this.changeAmount = 0,
    this.referenceNumber,
    this.memberCode,
    required this.paymentStatus,
    this.paidAt,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentResponseModel(
        id: json['id'] as String,
        workOrderId: json['workOrderId'] as String,
        paymentMethod: json['paymentMethod'] as String,
        paidAmount: json['paidAmount'] as int,
        totalAmount: json['totalAmount'] as int,
        taxAmount: json['taxAmount'] as int,
        changeAmount: json['changeAmount'] as int? ?? 0,
        referenceNumber: json['referenceNumber'] as String?,
        memberCode: json['memberCode'] as String?,
        paymentStatus: json['paymentStatus'] as String,
        paidAt: json['paidAt'] != null
            ? DateTime.parse(json['paidAt'] as String)
            : null,
      );

  PaymentResult toEntity() => PaymentResult(
        id: id,
        workOrderId: workOrderId,
        paymentMethod: paymentMethod,
        paidAmount: paidAmount,
        totalAmount: totalAmount,
        taxAmount: taxAmount,
        changeAmount: changeAmount,
        paymentStatus: paymentStatus,
        paidAt: paidAt,
      );

  @override
  List<Object?> get props => [
        id,
        workOrderId,
        paymentMethod,
        paidAmount,
        totalAmount,
        taxAmount,
        changeAmount,
        referenceNumber,
        memberCode,
        paymentStatus,
        paidAt,
      ];
}
