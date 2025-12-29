import 'package:equatable/equatable.dart';
import '../../../membership/domain/entities/membership.dart';
import '../../../work_order/domain/entities/work_order.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final Membership? membership;
  final List<WorkOrder>? workOrders;

  const Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.membership,
    this.workOrders,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, email, membership, workOrders];
}
