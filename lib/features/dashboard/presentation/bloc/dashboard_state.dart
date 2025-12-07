import 'package:equatable/equatable.dart';
import '../../../work_order/domain/entities/work_order.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int totalOrders;
  final int totalRevenue;
  final List<WorkOrder> recentOrders;
  final List<WorkOrder> filteredOrders;
  final Map<String, String> customerNames;
  final Map<String, String> vehicleNames;
  final Map<String, int> statusCounts;
  final String selectedStatus;

  const DashboardLoaded({
    required this.totalOrders,
    required this.totalRevenue,
    required this.recentOrders,
    this.filteredOrders = const [],
    this.customerNames = const {},
    this.vehicleNames = const {},
    this.statusCounts = const {},
    this.selectedStatus = 'Semua',
  });

  @override
  List<Object> get props => [
        totalOrders,
        totalRevenue,
        recentOrders,
        filteredOrders,
        customerNames,
        vehicleNames,
        statusCounts,
        selectedStatus,
      ];

  DashboardLoaded copyWith({
    int? totalOrders,
    int? totalRevenue,
    List<WorkOrder>? recentOrders,
    List<WorkOrder>? filteredOrders,
    Map<String, String>? customerNames,
    Map<String, String>? vehicleNames,
    Map<String, int>? statusCounts,
    String? selectedStatus,
  }) {
    return DashboardLoaded(
      totalOrders: totalOrders ?? this.totalOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      recentOrders: recentOrders ?? this.recentOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      customerNames: customerNames ?? this.customerNames,
      vehicleNames: vehicleNames ?? this.vehicleNames,
      statusCounts: statusCounts ?? this.statusCounts,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
  @override
  List<Object> get props => [message];
}
