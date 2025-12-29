import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<List<CustomerModel>> getCustomers();
  Future<CustomerModel> getCustomer(String id);
  Future<CustomerModel> createCustomer(CustomerModel customer);
  Future<CustomerModel> updateCustomer(CustomerModel customer);
  Future<void> deleteCustomer(String id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Dio dio;

  // Dummy data store
  static List<CustomerModel> _dummyCustomers = [
    const CustomerModel(
      id: "CUST-001",
      name: "John Doe",
      phoneNumber: "081234567890",
      email: "john.doe@example.com",
    ),
    const CustomerModel(
      id: "CUST-002",
      name: "Jane Smith",
      phoneNumber: "081234567891",
      email: "jane.smith@example.com",
    ),
    const CustomerModel(
      id: "CUST-003",
      name: "Michael Johnson",
      phoneNumber: "081234567892",
      email: "michael.j@example.com",
    ),
    const CustomerModel(
      id: "CUST-004",
      name: "Emily Davis",
      phoneNumber: "081234567893",
      email: "emily.d@example.com",
    ),
    const CustomerModel(
      id: "CUST-005",
      name: "William Brown",
      phoneNumber: "081234567894",
      email: "william.b@example.com",
    ),
    const CustomerModel(
      id: "CUST-006",
      name: "Olivia Wilson",
      phoneNumber: "081234567895",
      email: "olivia.w@example.com",
    ),
    const CustomerModel(
      id: "CUST-007",
      name: "James Taylor",
      phoneNumber: "081234567896",
      email: "james.t@example.com",
    ),
    const CustomerModel(
      id: "CUST-008",
      name: "Sophia Anderson",
      phoneNumber: "081234567897",
      email: "sophia.a@example.com",
    ),
    const CustomerModel(
      id: "CUST-009",
      name: "Robert Thomas",
      phoneNumber: "081234567898",
      email: "robert.t@example.com",
    ),
    const CustomerModel(
      id: "CUST-010",
      name: "Isabella Martinez",
      phoneNumber: "081234567899",
      email: "isabella.m@example.com",
    ),
    const CustomerModel(
      id: "CUST-011",
      name: "David White",
      phoneNumber: "081234567800",
      email: "david.w@example.com",
    ),
    const CustomerModel(
      id: "CUST-012",
      name: "Mia Harris",
      phoneNumber: "081234567801",
      email: "mia.h@example.com",
    ),
    const CustomerModel(
      id: "CUST-013",
      name: "Joseph Martin",
      phoneNumber: "081234567802",
      email: "joseph.m@example.com",
    ),
    const CustomerModel(
      id: "CUST-014",
      name: "Charlotte Thompson",
      phoneNumber: "081234567803",
      email: "charlotte.t@example.com",
    ),
    const CustomerModel(
      id: "CUST-015",
      name: "Charles Garcia",
      phoneNumber: "081234567804",
      email: "charles.g@example.com",
    ),
  ];

  CustomerRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CustomerModel>> getCustomers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_dummyCustomers);
  }

  @override
  Future<CustomerModel> getCustomer(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    final customer = _dummyCustomers.firstWhere(
      (c) => c.id == id,
      orElse: () => throw ServerFailure("Customer not found"),
    );
    return customer;
  }

  @override
  Future<CustomerModel> createCustomer(CustomerModel customer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newCustomer = customer.copyWith(
      id: "CUST-${DateTime.now().millisecondsSinceEpoch}",
    );
    _dummyCustomers.add(newCustomer);
    return newCustomer;
  }

  @override
  Future<CustomerModel> updateCustomer(CustomerModel customer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _dummyCustomers.indexWhere((c) => c.id == customer.id);
    if (index != -1) {
      _dummyCustomers[index] = customer;
      return customer;
    } else {
      throw ServerFailure("Customer not found");
    }
  }

  @override
  Future<void> deleteCustomer(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _dummyCustomers.removeWhere((c) => c.id == id);
  }
}
