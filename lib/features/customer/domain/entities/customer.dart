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

  static List<Customer> mockData() {
    return List.generate(
      100,
      (index) => Customer(
        id: 'dummy_customer_$index',
        name: 'Customer ${index + 1}',
        phoneNumber: '08123456789$index',
        email: 'customer${index + 1}@example.com',
      ),
    );
  }
}
