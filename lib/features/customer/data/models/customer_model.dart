import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/pagination/paginated_response_model.dart';
import '../../domain/entities/customer.dart';
import '../../../membership/data/models/membership_model.dart';
import '../../../work_order/data/models/work_order_model.dart';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final MembershipModel? membership;
  final List<WorkOrderModel>? workOrders;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.membership,
    this.workOrders,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"] as String,
        name: json["name"] as String,
        phoneNumber: json["phoneNumber"] as String,
        email: json["email"] as String,
        membership: json["membership"] != null
            ? MembershipModel.fromJson(json["membership"] as Map<String, dynamic>)
            : null,
        workOrders: json["workOrders"] != null
            ? (json["workOrders"] as List)
                .map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        if (membership != null) "membership": membership!.toJson(),
        if (workOrders != null) "workOrders": workOrders!.map((e) => e.toJson()).toList(),
      };

  CustomerModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    MembershipModel? membership,
    List<WorkOrderModel>? workOrders,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      membership: membership ?? this.membership,
      workOrders: workOrders ?? this.workOrders,
    );
  }

  Customer toEntity() => Customer(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        membership: membership?.toEntity(),
        workOrders: workOrders?.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [id, name, phoneNumber, email, membership, workOrders];

  /// Get paginated and filtered prototype data
  static PaginatedResponseModel<CustomerModel> getPaginatedPrototypeData({
    int page = 1,
    int limit = 10,
    String? query,
  }) {
    final allCustomers = getPrototypeDataCustomers;

    // Filter by query if provided
    List<CustomerModel> filteredCustomers = allCustomers;
    if (query != null && query.isNotEmpty) {
      filteredCustomers = allCustomers
          .where((c) =>
              c.name.toLowerCase().contains(query.toLowerCase()) ||
              c.phoneNumber.contains(query) ||
              c.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    // Apply pagination
    final total = filteredCustomers.length;
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;
    final paginatedData = filteredCustomers.sublist(
      startIndex,
      endIndex > total ? total : endIndex,
    );

    final totalPages = (total / limit).ceil();

    return PaginatedResponseModel<CustomerModel>(
      data: paginatedData,
      total: total,
      page: page,
      limit: limit,
      totalPages: totalPages > 0 ? totalPages : 1,
    );
  }

  /// Static getter for prototype dummy data
  static List<CustomerModel> get getPrototypeDataCustomers {
    return const [
      // Customer 1 - Premium Member
      CustomerModel(
        id: 'cust-001',
        name: 'Ahmad Yani',
        phoneNumber: '081234567890',
        email: 'ahmad.yani@email.com',
      ),

      // Customer 2 - Gold Member
      CustomerModel(
        id: 'cust-002',
        name: 'Siti Nurhaliza',
        phoneNumber: '081234567891',
        email: 'siti.nurhaliza@email.com',
      ),

      // Customer 3 - Silver Member
      CustomerModel(
        id: 'cust-003',
        name: 'Budi Santoso',
        phoneNumber: '081234567892',
        email: 'budi.santoso@email.com',
      ),

      // Customer 4 - Regular
      CustomerModel(
        id: 'cust-004',
        name: 'Rina Kusuma',
        phoneNumber: '081234567893',
        email: 'rina.kusuma@email.com',
      ),

      // Customer 5 - Premium Member
      CustomerModel(
        id: 'cust-005',
        name: 'Agus Salim',
        phoneNumber: '081234567894',
        email: 'agus.salim@email.com',
      ),

      // Customer 6 - Regular
      CustomerModel(
        id: 'cust-006',
        name: 'Maya Sari',
        phoneNumber: '081234567895',
        email: 'maya.sari@email.com',
      ),

      // Customer 7 - Gold Member
      CustomerModel(
        id: 'cust-007',
        name: 'Dedi Wijaya',
        phoneNumber: '081234567896',
        email: 'dedi.wijaya@email.com',
      ),

      // Customer 8 - Regular
      CustomerModel(
        id: 'cust-008',
        name: 'Lina Marlina',
        phoneNumber: '081234567897',
        email: 'lina.marlina@email.com',
      ),

      // Customer 9 - Silver Member
      CustomerModel(
        id: 'cust-009',
        name: 'Hendra Gunawan',
        phoneNumber: '081234567898',
        email: 'hendra.gunawan@email.com',
      ),

      // Customer 10 - Regular
      CustomerModel(
        id: 'cust-010',
        name: 'Dewi Lestari',
        phoneNumber: '081234567899',
        email: 'dewi.lestari@email.com',
      ),

      // Customer 11 - Premium Member
      CustomerModel(
        id: 'cust-011',
        name: 'Bambang Sutejo',
        phoneNumber: '081234567800',
        email: 'bambang.sutejo@email.com',
      ),

      // Customer 12 - Gold Member
      CustomerModel(
        id: 'cust-012',
        name: 'Yuni Shara',
        phoneNumber: '081234567801',
        email: 'yuni.shara@email.com',
      ),

      // Customer 13 - Regular
      CustomerModel(
        id: 'cust-013',
        name: 'Iwan Setiawan',
        phoneNumber: '081234567802',
        email: 'iwan.setiawan@email.com',
      ),

      // Customer 14 - Silver Member
      CustomerModel(
        id: 'cust-014',
        name: 'Ratna Sari',
        phoneNumber: '081234567803',
        email: 'ratna.sari@email.com',
      ),

      // Customer 15 - Regular
      CustomerModel(
        id: 'cust-015',
        name: 'Joko Widodo',
        phoneNumber: '081234567804',
        email: 'joko.widodo@email.com',
      ),
    ];
  }
}
