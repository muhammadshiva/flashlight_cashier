import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/product_usecases.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final CreateProduct createProduct;
  final DeleteProduct deleteProduct;

  ProductBloc({
    required this.getProducts,
    required this.createProduct,
    required this.deleteProduct,
  }) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await getProducts(NoParams());
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductLoaded(products)),
      );
    });

    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await createProduct(event.product);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (_) {
          emit(const ProductOperationSuccess("Product created"));
          add(LoadProducts());
        },
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await deleteProduct(event.id);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (_) {
          emit(const ProductOperationSuccess("Product deleted"));
          add(LoadProducts());
        },
      );
    });
  }
}
