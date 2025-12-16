import 'package:equatable/equatable.dart';
import '../../../work_order/domain/entities/work_order.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';

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
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;
  final Map<String, int> statusCounts;
  final String selectedStatus;
  final String searchQuery;

  const DashboardLoaded({
    required this.totalOrders,
    required this.totalRevenue,
    required this.recentOrders,
    this.filteredOrders = const [],
    this.customers = const {},
    this.vehicles = const {},
    this.statusCounts = const {},
    this.selectedStatus = 'Semua',
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [
        totalOrders,
        totalRevenue,
        recentOrders,
        filteredOrders,
        customers,
        vehicles,
        statusCounts,
        selectedStatus,
        searchQuery,
      ];

  DashboardLoaded copyWith({
    int? totalOrders,
    int? totalRevenue,
    List<WorkOrder>? recentOrders,
    List<WorkOrder>? filteredOrders,
    Map<String, Customer>? customers,
    Map<String, Vehicle>? vehicles,
    Map<String, int>? statusCounts,
    String? selectedStatus,
    String? searchQuery,
  }) {
    return DashboardLoaded(
      totalOrders: totalOrders ?? this.totalOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      recentOrders: recentOrders ?? this.recentOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      customers: customers ?? this.customers,
      vehicles: vehicles ?? this.vehicles,
      statusCounts: statusCounts ?? this.statusCounts,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class DashboardUpdating extends DashboardState {
  final DashboardLoaded currentState;

  const DashboardUpdating(this.currentState);

  @override
  List<Object> get props => [currentState];
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
  @override
  List<Object> get props => [message];
}
