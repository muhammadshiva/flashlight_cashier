import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response_model.dart';
import '../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<PaginatedResponseModel<CustomerModel>> getCustomers({
    PaginationParams? pagination,
    String? query,
  });
  Future<CustomerModel> getCustomer(String id);
  Future<CustomerModel> createCustomer(CustomerModel customer);
  Future<CustomerModel> updateCustomer(CustomerModel customer);
  Future<void> deleteCustomer(String id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Dio dio;

  // Dummy data store
  static List<CustomerModel> _dummyCustomers = [
    // ... existing dummy data ... (I will preserve this if I don't replace the whole list, but for now I'll just assume I can access the list or should re-declare it if I replace the whole class. Wait, replace_file_content replaces chunks. I should replace relevant parts.)
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
  Future<PaginatedResponseModel<CustomerModel>> getCustomers({
    PaginationParams? pagination,
    String? query,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Default pagination values
    final page = pagination?.page ?? 1;
    final limit = pagination?.limit ?? 10;
    final offset = pagination?.offset ?? 0;

    // Filter by query if present
    var filteredList = _dummyCustomers;
    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      filteredList = _dummyCustomers.where((customer) {
        return customer.name.toLowerCase().contains(lowercaseQuery) ||
            customer.phoneNumber.contains(lowercaseQuery) ||
            customer.email.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }

    // Calculate pagination
    final total = filteredList.length;
    final totalPages = (total / limit).ceil();
    final startIndex = ((page - 1) * limit) + offset;
    final endIndex = (startIndex + limit).clamp(0, total);

    // Get paginated data
    final paginatedData = filteredList.sublist(
      startIndex.clamp(0, total),
      endIndex,
    );

    return PaginatedResponseModel<CustomerModel>(
      data: paginatedData,
      total: total,
      page: page,
      limit: limit,
      totalPages: totalPages,
    );
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
