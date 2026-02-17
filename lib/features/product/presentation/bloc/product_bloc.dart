import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      final result = await getProducts(const GetProductsParams(isProtype: true));
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (paginatedProducts) {
          final productList = paginatedProducts.data;
          const itemsPerPage = 10;
          final totalItems = productList.length;
          final firstPageProducts = productList.take(itemsPerPage).toList();

          emit(ProductLoaded(
            products: firstPageProducts,
            allProducts: productList, // Initial list is full list
            sourceProducts: productList, // Master source
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

    on<ChangeItemsPerPageEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final allProducts = currentState.allProducts;
        final newItemsPerPage = event.itemsPerPage;

        final paginatedProducts = allProducts.take(newItemsPerPage).toList();

        emit(ProductLoaded(
          products: paginatedProducts,
          allProducts: allProducts,
          sourceProducts: currentState.sourceProducts,
          currentPage: 1,
          totalItems: allProducts.length,
          itemsPerPage: newItemsPerPage,
        ));
      }
    });

    on<SearchProductsEvent>((event, emit) async {
      final query = event.query.trim();

      // Below minimum characters → reload all products
      if (query.length < _minSearchLength) {
        emit(ProductLoading());
        final result = await getProducts(const GetProductsParams(isProtype: true));
        result.fold(
          (failure) => emit(ProductError(failure.message)),
          (paginatedProducts) {
            final productList = paginatedProducts.data;
            const itemsPerPage = 10;
            final totalItems = productList.length;
            final firstPageProducts = productList.take(itemsPerPage).toList();

            emit(ProductLoaded(
              products: firstPageProducts,
              allProducts: productList,
              sourceProducts: productList,
              currentPage: 1,
              totalItems: totalItems,
              itemsPerPage: itemsPerPage,
            ));
          },
        );
        return;
      }

      // Meets minimum → search via API
      emit(ProductLoading());
      final result = await getProducts(GetProductsParams(
        search: query,
        isProtype: true,
      ));
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (paginatedProducts) {
          final productList = paginatedProducts.data;
          const itemsPerPage = 10;
          final totalItems = productList.length;
          final firstPageProducts = productList.take(itemsPerPage).toList();

          emit(ProductLoaded(
            products: firstPageProducts,
            allProducts: productList,
            sourceProducts: productList,
            currentPage: 1,
            totalItems: totalItems,
            itemsPerPage: itemsPerPage,
          ));
        },
      );
    }, transformer: _debounce(const Duration(seconds: 1)));

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

  /// Minimum characters required to trigger API search
  static const int _minSearchLength = 3;

  /// Pure-Dart debounce EventTransformer.
  /// Debounces the event stream so only the last event after [duration] is processed.
  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) {
      final controller = StreamController<E>();
      Timer? timer;

      events.listen(
        (event) {
          timer?.cancel();
          timer = Timer(duration, () => controller.add(event));
        },
        onDone: () {
          timer?.cancel();
          controller.close();
        },
      );

      return controller.stream.asyncExpand(mapper);
    };
  }
}
