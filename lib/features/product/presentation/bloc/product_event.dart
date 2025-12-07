part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final Product product;
  const CreateProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  const DeleteProductEvent(this.id);
  @override
  List<Object> get props => [id];
}
