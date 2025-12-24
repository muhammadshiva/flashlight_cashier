part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> allProducts;
  final List<Product> sourceProducts;
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  const ProductLoaded({
    required this.products,
    required this.allProducts,
    required this.sourceProducts,
    this.currentPage = 1,
    this.totalItems = 0,
    this.itemsPerPage = 10,
  });

  @override
  List<Object> get props => [
        products,
        allProducts,
        sourceProducts,
        currentPage,
        totalItems,
        itemsPerPage
      ];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object> get props => [message];
}

class ProductOperationSuccess extends ProductState {
  final String message;
  const ProductOperationSuccess(this.message);
  @override
  List<Object> get props => [message];
}
