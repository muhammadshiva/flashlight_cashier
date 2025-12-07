import 'package:bloc/bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../work_order/domain/usecases/work_order_usecases.dart';
import '../../../customer/domain/usecases/get_customers.dart';
import '../../../vehicle/domain/usecases/vehicle_usecases.dart';
import '../../../work_order/domain/entities/work_order.dart'; // Explicit import
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetWorkOrders getWorkOrders;
  final GetCustomers getCustomers;
  final GetVehicles getVehicles;

  DashboardBloc({
    required this.getWorkOrders,
    required this.getCustomers,
    required this.getVehicles,
  }) : super(DashboardInitial()) {
    on<LoadDashboardStats>(_onLoadDashboardStats);
    on<FilterWorkOrders>(_onFilterWorkOrders);
  }

  Future<void> _onLoadDashboardStats(
      LoadDashboardStats event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());

    final workOrderResult = await getWorkOrders(NoParams());
    final customerResult = await getCustomers(NoParams());
    final vehicleResult = await getVehicles(NoParams());

    workOrderResult.fold(
      (failure) => emit(DashboardError(failure.message)),
      (orders) {
        // Build Maps
        final customerMap = <String, String>{};
        customerResult.fold(
          (l) => null,
          (customers) => {for (var c in customers) customerMap[c.id] = c.name},
        );

        final vehicleMap = <String, String>{};
        vehicleResult.fold(
          (l) => null,
          (vehicles) => {
            for (var v in vehicles)
              vehicleMap[v.id] =
                  '${v.vehicleBrand} ${v.vehicleSpecs} - ${v.licensePlate}'
          },
        );

        // Stats
        final totalRevenue =
            orders.fold(0, (sum, order) => sum + order.totalPrice);

        // Status Counts
        final statusCounts = <String, int>{'Semua': orders.length};
        for (var order in orders) {
          final status = order.status; // Case sensitive? Standardize if needed
          statusCounts[status] = (statusCounts[status] ?? 0) + 1;
        }

        // Default: Sort by date descending
        final sortedOrders = List<WorkOrder>.from(orders)
          ..sort((a, b) => (b.createdAt ?? DateTime.now())
              .compareTo(a.createdAt ?? DateTime.now()));

        emit(DashboardLoaded(
          totalOrders: orders.length,
          totalRevenue: totalRevenue,
          recentOrders: sortedOrders, // Keep all for filtering, or just top?
          filteredOrders: sortedOrders,
          customerNames: customerMap,
          vehicleNames: vehicleMap,
          statusCounts: statusCounts,
          selectedStatus: 'Semua',
        ));
      },
    );
  }

  void _onFilterWorkOrders(
      FilterWorkOrders event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      final allOrders = currentState
          .recentOrders; // Assuming recentOrders holds ALL loaded orders for now

      String filterStatus = event.status ?? currentState.selectedStatus;
      String filterQuery =
          event.searchQuery ?? ''; // Add search query state if needed

      List<WorkOrder> filtered = allOrders;

      // 1. Filter by Status
      if (filterStatus != 'Semua') {
        filtered = filtered
            .where((o) => o.status.toLowerCase() == filterStatus.toLowerCase())
            .toList();
      }

      // 2. Filter by Search (Mock logic for now, basic check)
      // Future: Search in customerNames map too
      if (filterQuery.isNotEmpty) {
        final query = filterQuery.toLowerCase();
        filtered = filtered.where((o) {
          final customerName =
              currentState.customerNames[o.customerId]?.toLowerCase() ?? '';
          final vehicleName =
              currentState.vehicleNames[o.vehicleDataId]?.toLowerCase() ?? '';
          return o.workOrderCode.toLowerCase().contains(query) ||
              customerName.contains(query) ||
              vehicleName.contains(query);
        }).toList();
      }

      emit(currentState.copyWith(
        filteredOrders: filtered,
        selectedStatus: filterStatus,
      ));
    }
  }
}
