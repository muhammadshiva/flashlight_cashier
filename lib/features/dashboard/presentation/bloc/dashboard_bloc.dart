import 'package:bloc/bloc.dart';
import 'package:flashlight_pos/features/work_order/domain/usecases/work_order_usecases.dart';

import '../../../../core/utils/dummy_data.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../customer/domain/usecases/get_customers.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../vehicle/domain/usecases/vehicle_usecases.dart';
import '../../../work_order/domain/entities/work_order.dart';
import '../../../work_order/domain/usecases/update_work_order_status.dart';

import '../../../service/domain/entities/service_entity.dart';
import '../../../product/domain/entities/product.dart';
import '../../../work_order/domain/entities/work_order_service.dart';
import '../../../work_order/domain/entities/work_order_product.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetWorkOrders getWorkOrders;
  final GetCustomers getCustomers;
  final GetVehicles getVehicles;
  final UpdateWorkOrderStatus updateWorkOrderStatus;

  DashboardBloc({
    required this.getWorkOrders,
    required this.getCustomers,
    required this.getVehicles,
    required this.updateWorkOrderStatus,
  }) : super(DashboardInitial()) {
    on<LoadDashboardStats>(_onLoadDashboardStats);
    on<RefreshDashboard>(_onRefreshDashboard);
    on<FilterWorkOrders>(_onFilterWorkOrders);
    on<UpdateWorkOrderStatusEvent>(_onUpdateWorkOrderStatus);
    on<AddWorkOrderItemEvent>(_onAddWorkOrderItem);
    on<RemoveWorkOrderItemEvent>(_onRemoveWorkOrderItem);
  }

  Future<void> _onLoadDashboardStats(
      LoadDashboardStats event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    await _loadDashboardData(emit);
  }

  Future<void> _onRefreshDashboard(
      RefreshDashboard event, Emitter<DashboardState> emit) async {
    // Refresh without showing full loading state
    await _loadDashboardData(emit);
  }

  Future<void> _loadDashboardData(Emitter<DashboardState> emit) async {
    // Use dummy data instead of API
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay

    try {
      // Get dummy data
      final orders = DummyData.getWorkOrders();
      final customers = DummyData.customers;
      final vehicles = DummyData.vehicles;

      // Build Customer Map
      final customerMap = <String, Customer>{};
      for (var c in customers) {
        customerMap[c.id] = c;
      }

      // Build Vehicle Map
      final vehicleMap = <String, Vehicle>{};
      for (var v in vehicles) {
        vehicleMap[v.id] = v;
      }

      // Stats
      final totalRevenue =
          orders.fold(0, (sum, order) => sum + order.totalPrice);

      // Status Counts
      final statusCounts = <String, int>{'Semua': orders.length};
      for (var order in orders) {
        final status = order.status;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      }

      // Sort by date descending (newest first)
      final sortedOrders = List<WorkOrder>.from(orders)
        ..sort((a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));

      emit(DashboardLoaded(
        totalOrders: orders.length,
        totalRevenue: totalRevenue,
        recentOrders: sortedOrders,
        filteredOrders: sortedOrders,
        customers: customerMap,
        vehicles: vehicleMap,
        statusCounts: statusCounts,
        selectedStatus: 'Semua',
      ));
    } catch (e) {
      emit(DashboardError('Failed to load data: ${e.toString()}'));
    }
  }

  void _onFilterWorkOrders(
      FilterWorkOrders event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      final allOrders = currentState.recentOrders;

      String filterStatus = event.status ?? currentState.selectedStatus;
      String filterQuery = event.searchQuery ?? currentState.searchQuery;

      List<WorkOrder> filtered = allOrders;

      // 1. Filter by Status
      if (filterStatus != 'Semua') {
        filtered = filtered
            .where((o) => o.status.toLowerCase() == filterStatus.toLowerCase())
            .toList();
      }

      // 2. Filter by Search Query
      if (filterQuery.isNotEmpty) {
        final query = filterQuery.toLowerCase();
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

      emit(currentState.copyWith(
        filteredOrders: filtered,
        selectedStatus: filterStatus,
        searchQuery: filterQuery,
      ));
    }
  }

  Future<void> _onUpdateWorkOrderStatus(
      UpdateWorkOrderStatusEvent event, Emitter<DashboardState> emit) async {
    if (state is! DashboardLoaded) return;

    final currentState = state as DashboardLoaded;

    // Emit updating state to show loading indicator
    emit(DashboardUpdating(currentState));

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // Find the work order to update
      final workOrder = currentState.recentOrders.firstWhere(
        (wo) => wo.id == event.workOrderId,
      );

      // Create updated work order with new status
      final updatedWorkOrder = WorkOrder(
        id: workOrder.id,
        workOrderCode: workOrder.workOrderCode,
        customerId: workOrder.customerId,
        vehicleDataId: workOrder.vehicleDataId,
        queueNumber: workOrder.queueNumber,
        estimatedTime: workOrder.estimatedTime,
        status: event.newStatus,
        paymentStatus: workOrder.paymentStatus,
        paymentMethod: workOrder.paymentMethod,
        paidAmount: workOrder.paidAmount,
        totalPrice: workOrder.totalPrice,
        services: workOrder.services,
        products: workOrder.products,
        createdAt: workOrder.createdAt,
        updatedAt: DateTime.now(),
        completedAt: event.newStatus == 'completed'
            ? DateTime.now()
            : workOrder.completedAt,
      );

      // Update the work order in the list (in-memory for dummy data)
      final updatedOrders = currentState.recentOrders.map((wo) {
        return wo.id == event.workOrderId ? updatedWorkOrder : wo;
      }).toList();

      // Recalculate status counts
      final statusCounts = <String, int>{'Semua': updatedOrders.length};
      for (var order in updatedOrders) {
        final status = order.status;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      }

      // Sort again
      final sortedOrders = List<WorkOrder>.from(updatedOrders)
        ..sort((a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));

      // Apply current filters
      List<WorkOrder> filtered = sortedOrders;
      if (currentState.selectedStatus != 'Semua') {
        filtered = filtered
            .where((o) =>
                o.status.toLowerCase() ==
                currentState.selectedStatus.toLowerCase())
            .toList();
      }
      if (currentState.searchQuery.isNotEmpty) {
        final query = currentState.searchQuery.toLowerCase();
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

      emit(currentState.copyWith(
        recentOrders: sortedOrders,
        filteredOrders: filtered, // Simplified for this update
        statusCounts: statusCounts,
      ));
    } catch (e) {
      // On failure, emit error and restore previous state
      emit(DashboardError('Gagal update status: ${e.toString()}'));
      emit(currentState);
    }
  }

  Future<void> _onAddWorkOrderItem(
      AddWorkOrderItemEvent event, Emitter<DashboardState> emit) async {
    if (state is! DashboardLoaded) return;
    final currentState = state as DashboardLoaded;

    // emit(DashboardUpdating(currentState)); // Removed to prevent refresh
    // await Future.delayed(const Duration(milliseconds: 500));

    try {
      final workOrder = currentState.recentOrders
          .firstWhere((wo) => wo.id == event.workOrderId);

      List<WorkOrderService> newServices = List.from(workOrder.services);
      List<WorkOrderProduct> newProducts = List.from(workOrder.products);
      int addedPrice = 0;

      if (event.type == 'Service') {
        final serviceName = event.item['name'] as String;
        final servicePrice = event.item['price'] as int;

        // Mock Service Entity
        final serviceId = DateTime.now().millisecondsSinceEpoch.toString();
        final service = ServiceEntity(
          id: serviceId,
          name: serviceName,
          description: 'Added via Cashier',
          price: servicePrice,
          imageUrl: '',
          isDefault: false,
          isFavorite: false,
          type: 'addon',
          isActive: true,
        );

        final woService = WorkOrderService(
          id: 'WS-${DateTime.now().millisecondsSinceEpoch}',
          workOrderId: workOrder.id,
          serviceId: serviceId,
          quantity: 1,
          priceAtOrder: servicePrice,
          subtotal: servicePrice,
          service: service,
        );

        newServices.add(woService);
        addedPrice = servicePrice;
      } else {
        final prodName = event.item['name'] as String;
        final prodPrice = event.item['price'] as int;

        // Mock Product Entity
        final productId = DateTime.now().millisecondsSinceEpoch.toString();
        final product = Product(
          id: productId,
          name: prodName,
          description: 'Added via Cashier',
          price: prodPrice,
          imageUrl: '',
          type: 'addon',
          stock: 100,
          isAvailable: true,
        );

        final woProduct = WorkOrderProduct(
          id: 'WP-${DateTime.now().millisecondsSinceEpoch}',
          workOrderId: workOrder.id,
          productId: productId,
          quantity: 1,
          priceAtOrder: prodPrice,
          subtotal: prodPrice,
          product: product,
        );

        newProducts.add(woProduct);
        addedPrice = prodPrice;
      }

      // Create updated work order
      final updatedWorkOrder = WorkOrder(
        id: workOrder.id,
        workOrderCode: workOrder.workOrderCode,
        customerId: workOrder.customerId,
        vehicleDataId: workOrder.vehicleDataId,
        queueNumber: workOrder.queueNumber,
        estimatedTime: workOrder.estimatedTime,
        status: workOrder.status,
        paymentStatus: workOrder.paymentStatus,
        paymentMethod: workOrder.paymentMethod,
        paidAmount: workOrder.paidAmount,
        totalPrice: workOrder.totalPrice + addedPrice,
        services: newServices,
        products: newProducts,
        createdAt: workOrder.createdAt,
        updatedAt: DateTime.now(),
        completedAt: workOrder.completedAt,
      );

      // Update list
      final updatedOrders = currentState.recentOrders.map((wo) {
        return wo.id == event.workOrderId ? updatedWorkOrder : wo;
      }).toList();

      // Recalculate status counts to be safe (though status didn't change)
      final statusCounts = <String, int>{'Semua': updatedOrders.length};
      for (var order in updatedOrders) {
        final status = order.status;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      }

      // Sort
      final sortedOrders = List<WorkOrder>.from(updatedOrders)
        ..sort((a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));

      emit(currentState.copyWith(
        recentOrders: sortedOrders,
        filteredOrders: sortedOrders, // Simplified
        statusCounts: statusCounts,
      ));
    } catch (e) {
      emit(DashboardError('Failed to add item: $e'));
      emit(currentState);
    }
  }

  Future<void> _onRemoveWorkOrderItem(
      RemoveWorkOrderItemEvent event, Emitter<DashboardState> emit) async {
    if (state is! DashboardLoaded) return;
    final currentState = state as DashboardLoaded;

    // No loading state for smoother removal

    try {
      final workOrder = currentState.recentOrders
          .firstWhere((wo) => wo.id == event.workOrderId);

      List<WorkOrderService> newServices = List.from(workOrder.services);
      List<WorkOrderProduct> newProducts = List.from(workOrder.products);
      int removedPrice = 0;

      if (event.type == 'Service') {
        final itemToRemove =
            newServices.firstWhere((s) => s.id == event.itemId);
        removedPrice = itemToRemove
            .priceAtOrder; // Simplification: assuming quantity 1 or removal removes whole entry
        newServices.removeWhere((s) => s.id == event.itemId);
      } else {
        final itemToRemove =
            newProducts.firstWhere((p) => p.id == event.itemId);
        removedPrice = itemToRemove.priceAtOrder *
            itemToRemove.quantity; // Remove subtotal?
        // Note: For now assuming we remove the whole line item.
        // Ideally we should check subtotal field but priceAtOrder * quantity is safer if subtotal logic varies.
        // Actually, let's use the subtotal field if available, or calc it.
        // WorkOrderProduct has subtotal.
        removedPrice = itemToRemove.subtotal;
        newProducts.removeWhere((p) => p.id == event.itemId);
      }

      // Create updated work order
      final updatedWorkOrder = WorkOrder(
        id: workOrder.id,
        workOrderCode: workOrder.workOrderCode,
        customerId: workOrder.customerId,
        vehicleDataId: workOrder.vehicleDataId,
        queueNumber: workOrder.queueNumber,
        estimatedTime: workOrder.estimatedTime,
        status: workOrder.status,
        paymentStatus: workOrder.paymentStatus,
        paymentMethod: workOrder.paymentMethod,
        paidAmount: workOrder.paidAmount,
        totalPrice: workOrder.totalPrice - removedPrice,
        services: newServices,
        products: newProducts,
        createdAt: workOrder.createdAt,
        updatedAt: DateTime.now(),
        completedAt: workOrder.completedAt,
      );

      // Update list
      final updatedOrders = currentState.recentOrders.map((wo) {
        return wo.id == event.workOrderId ? updatedWorkOrder : wo;
      }).toList();

      // Recalculate status counts
      final statusCounts = <String, int>{'Semua': updatedOrders.length};
      for (var order in updatedOrders) {
        final status = order.status;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      }

      // Sort
      final sortedOrders = List<WorkOrder>.from(updatedOrders)
        ..sort((a, b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));

      emit(currentState.copyWith(
        recentOrders: sortedOrders,
        filteredOrders: sortedOrders,
        statusCounts: statusCounts,
      ));
    } catch (e) {
      emit(DashboardError('Failed to remove item: $e'));
      emit(currentState);
    }
  }
}
