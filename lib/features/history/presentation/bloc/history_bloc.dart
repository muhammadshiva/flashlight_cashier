import 'package:bloc/bloc.dart';

import '../../../../core/utils/dummy_data.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../customer/domain/usecases/get_customers.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../vehicle/domain/usecases/vehicle_usecases.dart';
import '../../../work_order/domain/entities/work_order.dart';
import '../../../work_order/domain/usecases/work_order_usecases.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetWorkOrders getWorkOrders;
  final GetCustomers getCustomers;
  final GetVehicles getVehicles;

  HistoryBloc({
    required this.getWorkOrders,
    required this.getCustomers,
    required this.getVehicles,
  }) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<RefreshHistory>(_onRefreshHistory);
    on<FilterHistory>(_onFilterHistory);
  }

  Future<void> _onLoadHistory(
      LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    await _loadHistoryData(emit);
  }

  Future<void> _onRefreshHistory(
      RefreshHistory event, Emitter<HistoryState> emit) async {
    // Refresh without showing full loading state
    await _loadHistoryData(emit);
  }

  Future<void> _loadHistoryData(Emitter<HistoryState> emit) async {
    // Use dummy data instead of API
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay

    try {
      // Get dummy data
      final allOrders = DummyData.getWorkOrders();
      final customers = DummyData.customers;
      final vehicles = DummyData.vehicles;

      // Filter only completed and paid orders for history
      final historyOrders = allOrders
          .where((order) =>
              order.status.toLowerCase() == 'completed' ||
              order.status.toLowerCase() == 'paid')
          .toList();

      // Sort by completion date/updated date (newest first)
      historyOrders.sort((a, b) {
        final dateA = a.completedAt ?? a.updatedAt ?? a.createdAt ?? DateTime.now();
        final dateB = b.completedAt ?? b.updatedAt ?? b.createdAt ?? DateTime.now();
        return dateB.compareTo(dateA);
      });

      // Build customer map
      final customerMap = <String, Customer>{};
      for (var customer in customers) {
        customerMap[customer.id] = customer;
      }

      // Build vehicle map
      final vehicleMap = <String, Vehicle>{};
      for (var vehicle in vehicles) {
        vehicleMap[vehicle.id] = vehicle;
      }

      // Calculate status counts for completed and paid
      final statusCounts = <String, int>{
        'Semua': historyOrders.length,
      };

      for (var order in historyOrders) {
        final status = order.status;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      }

      emit(HistoryLoaded(
        historyOrders: historyOrders,
        filteredOrders: historyOrders,
        customers: customerMap,
        vehicles: vehicleMap,
        statusCounts: statusCounts,
      ));
    } catch (e) {
      emit(HistoryError('Failed to load history: ${e.toString()}'));
    }
  }

  Future<void> _onFilterHistory(
      FilterHistory event, Emitter<HistoryState> emit) async {
    if (state is! HistoryLoaded) return;

    final currentState = state as HistoryLoaded;
    List<WorkOrder> filtered = List.from(currentState.historyOrders);

    // Filter by status
    String selectedStatus = event.status ?? currentState.selectedStatus;
    if (selectedStatus != 'Semua') {
      filtered = filtered
          .where((o) => o.status.toLowerCase() == selectedStatus.toLowerCase())
          .toList();
    }

    // Filter by search query
    String searchQuery = event.searchQuery ?? currentState.searchQuery;
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((o) {
        final customer = currentState.customers[o.customerId];
        final vehicle = currentState.vehicles[o.vehicleDataId];

        final customerName = customer?.name.toLowerCase() ?? '';
        final customerPhone = customer?.phoneNumber.toLowerCase() ?? '';
        final vehicleInfo = vehicle != null
            ? '${vehicle.vehicleBrand} ${vehicle.vehicleSpecs} ${vehicle.licensePlate}'
                .toLowerCase()
            : '';

        return o.workOrderCode.toLowerCase().contains(query) ||
            customerName.contains(query) ||
            customerPhone.contains(query) ||
            vehicleInfo.contains(query);
      }).toList();
    }

    // Filter by date range
    DateTime? startDate = event.startDate ?? currentState.startDate;
    DateTime? endDate = event.endDate ?? currentState.endDate;

    if (startDate != null || endDate != null) {
      filtered = filtered.where((o) {
        final orderDate = o.completedAt ?? o.updatedAt ?? o.createdAt;
        if (orderDate == null) return false;

        if (startDate != null && orderDate.isBefore(startDate)) {
          return false;
        }
        if (endDate != null && orderDate.isAfter(endDate)) {
          return false;
        }
        return true;
      }).toList();
    }

    emit(currentState.copyWith(
      filteredOrders: filtered,
      selectedStatus: selectedStatus,
      searchQuery: searchQuery,
      startDate: startDate,
      endDate: endDate,
    ));
  }
}
