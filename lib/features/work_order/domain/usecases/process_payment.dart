import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/payment_result.dart';
import '../repositories/work_order_repository.dart';

class ProcessPayment implements UseCase<PaymentResult, ProcessPaymentParams> {
  final WorkOrderRepository repository;

  ProcessPayment(this.repository);

  @override
  Future<Either<Failure, PaymentResult>> call(
      ProcessPaymentParams params) async {
    return await repository.processPayment(params);
  }
}

class ProcessPaymentParams {
  final String workOrderId;
  final String paymentMethod;
  final int paidAmount;
  final int totalAmount;
  final int taxAmount;
  final int changeAmount;
  final String? referenceNumber;
  final String? memberCode;

  /// When true, returns prototype/mock success data without hitting the API.
  final bool isPrototypeSuccess;

  /// When true, returns prototype/mock error without hitting the API.
  final bool isPrototypeError;

  const ProcessPaymentParams({
    required this.workOrderId,
    required this.paymentMethod,
    required this.paidAmount,
    required this.totalAmount,
    required this.taxAmount,
    this.changeAmount = 0,
    this.referenceNumber,
    this.memberCode,
    this.isPrototypeSuccess = false,
    this.isPrototypeError = false,
  });
}
