import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int totalOrders;
  final int totalRevenue;
  final int pendingOrders;
  final int inProgressOrders;
  final int completedOrders;
  final int cancelledOrders;
  final Map<String, int> statusCounts;

  const DashboardStats({
    required this.totalOrders,
    required this.totalRevenue,
    required this.pendingOrders,
    required this.inProgressOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.statusCounts,
  });

  @override
  List<Object?> get props => [
        totalOrders,
        totalRevenue,
        pendingOrders,
        inProgressOrders,
        completedOrders,
        cancelledOrders,
        statusCounts,
      ];
}
