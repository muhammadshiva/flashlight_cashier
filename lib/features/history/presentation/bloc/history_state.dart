import 'package:equatable/equatable.dart';

import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../work_order/domain/entities/work_order.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<WorkOrder> historyOrders;
  final List<WorkOrder> filteredOrders;
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;
  final Map<String, int> statusCounts;
  final String selectedStatus; // 'Semua', 'completed', 'paid'
  final String searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  const HistoryLoaded({
    required this.historyOrders,
    this.filteredOrders = const [],
    this.customers = const {},
    this.vehicles = const {},
    this.statusCounts = const {},
    this.selectedStatus = 'Semua',
    this.searchQuery = '',
    this.startDate,
    this.endDate,
  });

  @override
  List<Object> get props => [
        historyOrders,
        filteredOrders,
        customers,
        vehicles,
        statusCounts,
        selectedStatus,
        searchQuery,
        if (startDate != null) startDate!,
        if (endDate != null) endDate!,
      ];

  HistoryLoaded copyWith({
    List<WorkOrder>? historyOrders,
    List<WorkOrder>? filteredOrders,
    Map<String, Customer>? customers,
    Map<String, Vehicle>? vehicles,
    Map<String, int>? statusCounts,
    String? selectedStatus,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return HistoryLoaded(
      historyOrders: historyOrders ?? this.historyOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      customers: customers ?? this.customers,
      vehicles: vehicles ?? this.vehicles,
      statusCounts: statusCounts ?? this.statusCounts,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
