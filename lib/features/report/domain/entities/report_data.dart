import 'package:equatable/equatable.dart';

class ReportData extends Equatable {
  final int totalRevenue;
  final int totalOrders;
  final Map<String, int> ordersByStatus;
  final List<TopCustomer> topCustomers;
  final List<PopularService> popularServices;

  const ReportData({
    required this.totalRevenue,
    required this.totalOrders,
    required this.ordersByStatus,
    required this.topCustomers,
    required this.popularServices,
  });

  @override
  List<Object?> get props => [
        totalRevenue,
        totalOrders,
        ordersByStatus,
        topCustomers,
        popularServices,
      ];
}

class TopCustomer extends Equatable {
  final String id;
  final String name;
  final int totalSpent;
  final int orderCount;

  const TopCustomer({
    required this.id,
    required this.name,
    required this.totalSpent,
    required this.orderCount,
  });

  @override
  List<Object?> get props => [id, name, totalSpent, orderCount];
}

class PopularService extends Equatable {
  final String id;
  final String name;
  final int orderCount;
  final int totalRevenue;

  const PopularService({
    required this.id,
    required this.name,
    required this.orderCount,
    required this.totalRevenue,
  });

  @override
  List<Object?> get props => [id, name, orderCount, totalRevenue];
}
