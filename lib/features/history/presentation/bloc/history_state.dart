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
  final List<WorkOrder> historyOrders; // Master list
  final List<WorkOrder> filteredOrders; // After filter (all pages)
  final List<WorkOrder> displayedOrders; // Current page only
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;
  final Map<String, int> statusCounts;
  final String selectedStatus; // 'Semua', 'completed', 'paid'
  final String searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  const HistoryLoaded({
    required this.historyOrders,
    this.filteredOrders = const [],
    this.displayedOrders = const [],
    this.customers = const {},
    this.vehicles = const {},
    this.statusCounts = const {},
    this.selectedStatus = 'Semua',
    this.searchQuery = '',
    this.startDate,
    this.endDate,
    this.currentPage = 1,
    this.totalItems = 0,
    this.itemsPerPage = 10,
  });

  @override
  List<Object> get props => [
        historyOrders,
        filteredOrders,
        displayedOrders,
        customers,
        vehicles,
        statusCounts,
        selectedStatus,
        searchQuery,
        currentPage,
        totalItems,
        itemsPerPage,
        if (startDate != null) startDate!,
        if (endDate != null) endDate!,
      ];

  HistoryLoaded copyWith({
    List<WorkOrder>? historyOrders,
    List<WorkOrder>? filteredOrders,
    List<WorkOrder>? displayedOrders,
    Map<String, Customer>? customers,
    Map<String, Vehicle>? vehicles,
    Map<String, int>? statusCounts,
    String? selectedStatus,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    int? currentPage,
    int? totalItems,
    int? itemsPerPage,
  }) {
    return HistoryLoaded(
      historyOrders: historyOrders ?? this.historyOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      displayedOrders: displayedOrders ?? this.displayedOrders,
      customers: customers ?? this.customers,
      vehicles: vehicles ?? this.vehicles,
      statusCounts: statusCounts ?? this.statusCounts,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currentPage: currentPage ?? this.currentPage,
      totalItems: totalItems ?? this.totalItems,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
    );
  }
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
