import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../customer/domain/usecases/get_customers.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/domain/usecases/product_usecases.dart';
import '../../../service/domain/entities/service_entity.dart';
import '../../../service/domain/usecases/service_usecases.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../vehicle/domain/usecases/vehicle_usecases.dart';
import '../../domain/entities/work_order.dart';
import '../../domain/entities/work_order_product.dart';
import '../../domain/entities/work_order_service.dart';
import '../../domain/usecases/work_order_usecases.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  final GetCustomers
      getCustomers; // Ensure this class is defined in customer_usecases.dart
  final GetVehicles getVehicles;
  final GetServices getServices;
  final GetProducts getProducts;
  final CreateWorkOrder createWorkOrder;

  PosBloc({
    required this.getCustomers,
    required this.getVehicles,
    required this.getServices,
    required this.getProducts,
    required this.createWorkOrder,
  }) : super(const PosState()) {
    on<LoadCatalog>(_onLoadCatalog);
    on<SelectCustomer>(_onSelectCustomer);
    on<SelectVehicle>(_onSelectVehicle);
    on<AddServiceToCart>(_onAddServiceToCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<SubmitOrder>(_onSubmitOrder);
    on<ResetPos>(_onResetPos);
  }

  Future<void> _onLoadCatalog(LoadCatalog event, Emitter<PosState> emit) async {
    emit(state.copyWith(status: PosStatus.loading));

    // Fetch all necessary data parallelly
    final results = await Future.wait<dynamic>([
      getServices(const GetServicesParams(isPrototype: true)),
      getProducts(const GetProductsParams()),
      getCustomers(const GetCustomersParams()),
      // Vehicles will be fetched when customer is selected, or we fetch all?
      // For now let's assume we fetch vehicles later or filter them.
      // But GetVehicles usecase usually returns all vehicles.
      getVehicles(NoParams()),
    ]);

    final servicesResult = results[0]; // Either<Failure, List<ServiceEntity>>
    final productsResult = results[1]; // Either<Failure, List<Product>>
    final customersResult = results[2]; // Either<Failure, PaginatedResponse<Customer>>
    // final vehiclesResult = results[3]; // Either<Failure, List<Vehicle>> (Unused for now)

    List<ServiceEntity> services = [];
    List<Product> products = [];
    List<Customer> customers = [];
    // List<Vehicle> vehicles = []; // All vehicles

    // Helper to unwrap
    servicesResult.fold((l) => /* log error */ null, (r) => services = r);
    productsResult.fold((l) => /* log error */ null, (r) => products = r);
    customersResult.fold((l) => /* log error */ null, (r) => customers = r.data);
    // vehiclesResult.fold(
    //     (l) => print('Error vehicles: ${l.message}'), (r) => vehicles = r);

    // We store all vehicles in a separate place or just filter on the fly?
    // Let's store all and filter locally for simplicity for now.
    // Ideally, we should have GetVehiclesByCustomer.
    // For now, let's just assume we can filter locally.

    emit(state.copyWith(
      status: PosStatus.loaded,
      availableServices: services,
      availableProducts: products,
      customers: customers,
      // We don't set customerVehicles yet
    ));

    // Hack: Store all vehicles in a private variable or just accessible via closure?
    // Better to store 'allVehicles' in state?
    // Let's just assume we fetch vehicles for selected customer effectively.
    // Since we don't have GetVehiclesByCustomer usecase yet, implementing filtering logic in SelectCustomer.
    // For now, let's just assume we can filter locally.
  }

  Future<void> _onSelectCustomer(
      SelectCustomer event, Emitter<PosState> emit) async {
    // When customer selected, we need to load/filter their vehicles.
    // Since we fetched ALL vehicles in LoadCatalog (which is expensive potentially, but okay for MVP),
    // we need to re-fetch/filter them.
    // Let's re-fetch all vehicles and filter.

    final vehicleResult = await getVehicles(NoParams());
    List<Vehicle> customerVehicles = [];
    vehicleResult.fold(
        (l) => null,
        (r) => customerVehicles = r
            .where((v) => v.vehicleCategory == 'S' || true)
            .toList() // Placeholder filter, need linking logic
        );

    // WAIT: Vehicle entity doesn't have customerId explicitly visible in previous code view?
    // Let's check Vehicle entity. 'MemberVehicle' has 'MembershipID'. 'VehicleData' has 'MemberVehicleID'?
    // The simplified Vehicle entity created in Step 166:
    // class Vehicle { id, licensePlate, vehicleBrand, ... }
    // It does NOT have customerId. This is a gap.
    // We need to link Vehicles to Customers.
    // backend: MemberVehicle -> Membership -> Customer.
    // Or WorkOrder -> VehicleData.
    // For MVP POS, maybe we just list all vehicles or Add New Vehicle on the fly?
    // Or we assume Vehicle entity has a link.
    // For now, let's just show ALL vehicles to allow selection.

    emit(state.copyWith(
      selectedCustomer: event.customer,
      customerVehicles: customerVehicles, // currently showing all
      selectedVehicle: null, // linking reset
    ));
  }

  void _onSelectVehicle(SelectVehicle event, Emitter<PosState> emit) {
    emit(state.copyWith(selectedVehicle: event.vehicle));
  }

  void _onAddServiceToCart(AddServiceToCart event, Emitter<PosState> emit) {
    final newItem = CartItem(
      id: event.service.id,
      name: event.service.name,
      price: event.service.price,
      quantity: 1,
      isService: true,
      originalItem: event.service,
    );
    emit(state.copyWith(cartItems: List.from(state.cartItems)..add(newItem)));
  }

  void _onAddProductToCart(AddProductToCart event, Emitter<PosState> emit) {
    final newItem = CartItem(
      id: event.product.id,
      name: event.product.name,
      price: event.product.price,
      quantity: 1,
      isService: false,
      originalItem: event.product,
    );
    emit(state.copyWith(cartItems: List.from(state.cartItems)..add(newItem)));
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<PosState> emit) {
    final newItems = List<CartItem>.from(state.cartItems);
    newItems.removeAt(event.index);
    emit(state.copyWith(cartItems: newItems));
  }

  Future<void> _onSubmitOrder(SubmitOrder event, Emitter<PosState> emit) async {
    if (state.selectedCustomer == null ||
        state.selectedVehicle == null ||
        state.cartItems.isEmpty) {
      emit(state.copyWith(
          status: PosStatus.error, errorMessage: "Missing information"));
      return;
    }

    emit(state.copyWith(status: PosStatus.loading));

    final workOrder = WorkOrder(
      id: '',
      workOrderCode:
          'WO-${DateTime.now().millisecondsSinceEpoch}', // Temporary gen
      customerId: state.selectedCustomer!.id,
      vehicleDataId: state.selectedVehicle!.id,
      queueNumber: 'A-001', // Temp
      estimatedTime: '1 hour', // Temp
      status: 'created',
      paymentStatus:
          'paid', // Assume immediate payment for POS for now, or 'pending'
      paymentMethod: event.paymentMethod,
      paidAmount: state.totalAmount, // Assume full payment
      totalPrice: state.totalAmount,
      services: state.cartItems
          .where((i) => i.isService)
          .map((i) => WorkOrderService(
              id: '',
              workOrderId: '',
              serviceId: i.id,
              quantity: i.quantity,
              priceAtOrder: i.price,
              subtotal: i.subtotal))
          .toList(),
      products: state.cartItems
          .where((i) => !i.isService)
          .map((i) => WorkOrderProduct(
              id: '',
              workOrderId: '',
              productId: i.id,
              quantity: i.quantity,
              priceAtOrder: i.price,
              subtotal: i.subtotal))
          .toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = await createWorkOrder(workOrder);
    result.fold(
      (l) => emit(
          state.copyWith(status: PosStatus.error, errorMessage: l.message)),
      (r) => emit(state.copyWith(
          status: PosStatus.success, errorMessage: "Order Created!")),
    );
  }

  void _onResetPos(ResetPos event, Emitter<PosState> emit) {
    emit(const PosState(
        status: PosStatus.loaded)); // Keep loaded data but reset selection?
    // Ideally we re-fetch or keep loaded data.
    add(LoadCatalog());
  }
}
