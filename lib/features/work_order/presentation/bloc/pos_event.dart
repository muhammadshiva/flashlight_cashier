part of 'pos_bloc.dart';

abstract class PosEvent extends Equatable {
  const PosEvent();
  @override
  List<Object?> get props => [];
}

class LoadCatalog extends PosEvent {}

class SelectCustomer extends PosEvent {
  final Customer customer;
  const SelectCustomer(this.customer);
  @override
  List<Object?> get props => [customer];
}

class SelectVehicle extends PosEvent {
  final Vehicle vehicle;
  const SelectVehicle(this.vehicle);
  @override
  List<Object?> get props => [vehicle];
}

class AddServiceToCart extends PosEvent {
  final ServiceEntity service;
  const AddServiceToCart(this.service);
  @override
  List<Object?> get props => [service];
}

class AddProductToCart extends PosEvent {
  final Product product;
  const AddProductToCart(this.product);
  @override
  List<Object?> get props => [product];
}

class RemoveItemFromCart extends PosEvent {
  final int index;
  const RemoveItemFromCart(this.index);
  @override
  List<Object?> get props => [index];
}

class SubmitOrder extends PosEvent {
  final String paymentMethod;
  const SubmitOrder({this.paymentMethod = 'cash'});
  @override
  List<Object?> get props => [paymentMethod];
}

class ResetPos extends PosEvent {}
