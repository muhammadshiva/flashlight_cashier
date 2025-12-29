import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/product_usecases.dart';
import '../../domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductBloc({
    required this.getProducts,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await getProducts(const GetProductsParams());
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) {
          const itemsPerPage = 10;
          final totalItems = products.length;
          final paginatedProducts = products.take(itemsPerPage).toList();

          emit(ProductLoaded(
            products: paginatedProducts,
            allProducts: products, // Initial list is full list
            sourceProducts: products, // Master source
            currentPage: 1,
            totalItems: totalItems,
            itemsPerPage: itemsPerPage,
          ));
        },
      );
    });

    on<ChangePageEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final allProducts = currentState.allProducts;
        final itemsPerPage = currentState.itemsPerPage;

        final startIndex = (event.page - 1) * itemsPerPage;
        if (startIndex >= allProducts.length) return;

        final endIndex = (startIndex + itemsPerPage) > allProducts.length
            ? allProducts.length
            : startIndex + itemsPerPage;

        final paginatedProducts = allProducts.sublist(startIndex, endIndex);

        emit(ProductLoaded(
          products: paginatedProducts,
          allProducts: allProducts,
          sourceProducts: currentState.sourceProducts,
          currentPage: event.page,
          totalItems: allProducts.length,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<SearchProductsEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final source = currentState.sourceProducts;

        final query = event.query.toLowerCase();
        final filtered = query.isEmpty
            ? source
            : source
                .where((p) =>
                    p.name.toLowerCase().contains(query) ||
                    p.id.toLowerCase().contains(query))
                .toList();

        const itemsPerPage = 10;
        final totalItems = filtered.length;
        // Reset to page 1
        final paginatedProducts = filtered.take(itemsPerPage).toList();

        emit(ProductLoaded(
          products: paginatedProducts,
          allProducts: filtered, // Working set is now filtered
          sourceProducts: source, // Keep master source
          currentPage: 1,
          totalItems: totalItems,
          itemsPerPage: itemsPerPage,
        ));
      }
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

    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await updateProduct(event.product);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (_) {
          emit(const ProductOperationSuccess("Product updated"));
          add(LoadProducts());
        },
      );
    });
  }
}
