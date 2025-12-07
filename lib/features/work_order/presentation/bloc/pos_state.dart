part of 'pos_bloc.dart';

enum PosStatus { initial, loading, loaded, success, error }

class CartItem extends Equatable {
  final String id; // Service or Product ID
  final String name;
  final int price;
  final int quantity;
  final bool isService;
  final dynamic originalItem; // ServiceEntity or Product

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isService,
    required this.originalItem,
  });

  int get subtotal => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      isService: isService,
      originalItem: originalItem,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, price, quantity, isService, originalItem];
}

class PosState extends Equatable {
  final PosStatus status;
  final String? errorMessage;
  final List<ServiceEntity> availableServices;
  final List<Product> availableProducts;
  final List<Customer> customers; // Ideally we search, but for now list all
  final List<Vehicle> customerVehicles; // Vehicles for selected customer

  final Customer? selectedCustomer;
  final Vehicle? selectedVehicle;
  final List<CartItem> cartItems;

  const PosState({
    this.status = PosStatus.initial,
    this.errorMessage,
    this.availableServices = const [],
    this.availableProducts = const [],
    this.customers = const [],
    this.customerVehicles = const [],
    this.selectedCustomer,
    this.selectedVehicle,
    this.cartItems = const [],
  });

  int get totalAmount => cartItems.fold(0, (sum, item) => sum + item.subtotal);

  PosState copyWith({
    PosStatus? status,
    String? errorMessage,
    List<ServiceEntity>? availableServices,
    List<Product>? availableProducts,
    List<Customer>? customers,
    List<Vehicle>? customerVehicles,
    Customer? selectedCustomer,
    Vehicle? selectedVehicle,
    List<CartItem>? cartItems,
  }) {
    return PosState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      availableServices: availableServices ?? this.availableServices,
      availableProducts: availableProducts ?? this.availableProducts,
      customers: customers ?? this.customers,
      customerVehicles: customerVehicles ?? this.customerVehicles,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        availableServices,
        availableProducts,
        customers,
        customerVehicles,
        selectedCustomer,
        selectedVehicle,
        cartItems,
      ];
}
