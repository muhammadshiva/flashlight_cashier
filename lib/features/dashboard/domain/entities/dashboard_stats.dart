import 'package:equatable/equatable.dart';

import '../../../work_order/domain/entities/work_order.dart';

class DashboardData extends Equatable {
  final int totalOrders;
  final int totalRevenue;
  final int pendingOrders;
  final int inProgressOrders;
  final int completedOrders;
  final int cancelledOrders;
  final List<StatusCount> statusCounts;

  const DashboardData({
    required this.totalOrders,
    required this.totalRevenue,
    required this.pendingOrders,
    required this.inProgressOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.statusCounts,
  });

  factory DashboardData.fromWorkOrders(List<WorkOrder> orders) {
    int totalRevenue = 0;
    // Helper map for counting
    final tempCounts = <String, int>{
      'Semua': orders.length,
    };

    for (var order in orders) {
      totalRevenue += order.totalPrice;
      final status = order.status;
      tempCounts[status] = (tempCounts[status] ?? 0) + 1;
    }

    // Convert map to List<StatusCount>
    final statusCountList =
        tempCounts.entries.map((e) => StatusCount(name: e.key, count: e.value)).toList();

    return DashboardData(
      totalOrders: orders.length,
      totalRevenue: totalRevenue,
      pendingOrders: tempCounts['queued'] ?? 0,
      inProgressOrders: (tempCounts['washing'] ?? 0) +
          (tempCounts['drying'] ?? 0) +
          (tempCounts['inspection'] ?? 0),
      completedOrders: (tempCounts['completed'] ?? 0) + (tempCounts['paid'] ?? 0),
      cancelledOrders: tempCounts['cancelled'] ?? 0,
      statusCounts: statusCountList,
    );
  }

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

class StatusCount extends Equatable {
  final String name;
  final int count;

  const StatusCount({
    required this.name,
    required this.count,
  });

  @override
  List<Object?> get props => [name, count];
}
