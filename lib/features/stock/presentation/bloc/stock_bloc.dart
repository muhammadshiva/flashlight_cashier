import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/entities/stock_adjustment.dart';
import '../../domain/usecases/stock_usecases.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetStockItems getStockItems;
  final AdjustStock adjustStock;
  final GetStockHistory getStockHistory;

  StockBloc({
    required this.getStockItems,
    required this.adjustStock,
    required this.getStockHistory,
  }) : super(StockInitial()) {
    on<LoadStockItems>((event, emit) async {
      emit(StockLoading());
      final result = await getStockItems(NoParams());
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (stockItems) {
          const itemsPerPage = 10;
          final totalItems = stockItems.length;
          final paginatedItems = stockItems.take(itemsPerPage).toList();

          emit(StockLoaded(
            stockItems: paginatedItems,
            allStockItems: stockItems,
            sourceStockItems: stockItems,
            currentPage: 1,
            totalItems: totalItems,
            itemsPerPage: itemsPerPage,
          ));
        },
      );
    });

    on<ChangePageEvent>((event, emit) {
      if (state is StockLoaded) {
        final currentState = state as StockLoaded;
        final allItems = currentState.allStockItems;
        final itemsPerPage = currentState.itemsPerPage;

        final startIndex = (event.page - 1) * itemsPerPage;
        if (startIndex >= allItems.length) return;

        final endIndex = (startIndex + itemsPerPage) > allItems.length
            ? allItems.length
            : startIndex + itemsPerPage;

        final paginatedItems = allItems.sublist(startIndex, endIndex);

        emit(StockLoaded(
          stockItems: paginatedItems,
          allStockItems: allItems,
          sourceStockItems: currentState.sourceStockItems,
          currentPage: event.page,
          totalItems: allItems.length,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<ChangeItemsPerPageEvent>((event, emit) {
      if (state is StockLoaded) {
        final currentState = state as StockLoaded;
        final allItems = currentState.allStockItems;
        final itemsPerPage = event.itemsPerPage;

        const currentPage = 1;
        final startIndex = (currentPage - 1) * itemsPerPage;
        final endIndex = (startIndex + itemsPerPage) > allItems.length
            ? allItems.length
            : startIndex + itemsPerPage;

        final paginatedItems = allItems.sublist(startIndex, endIndex);

        emit(StockLoaded(
          stockItems: paginatedItems,
          allStockItems: allItems,
          sourceStockItems: currentState.sourceStockItems,
          currentPage: currentPage,
          totalItems: allItems.length,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<SearchStockItemsEvent>((event, emit) {
      if (state is StockLoaded) {
        final currentState = state as StockLoaded;
        final source = currentState.sourceStockItems;

        final query = event.query.toLowerCase();
        final filtered = query.isEmpty
            ? source
            : source
                .where((p) =>
                    p.name.toLowerCase().contains(query) ||
                    p.id.toLowerCase().contains(query) ||
                    p.type.toLowerCase().contains(query))
                .toList();

        const itemsPerPage = 10;
        final totalItems = filtered.length;
        final paginatedItems = filtered.take(itemsPerPage).toList();

        emit(StockLoaded(
          stockItems: paginatedItems,
          allStockItems: filtered,
          sourceStockItems: source,
          currentPage: 1,
          totalItems: totalItems,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<AdjustStockEvent>((event, emit) async {
      emit(StockLoading());
      final result = await adjustStock(event.adjustment);
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (product) {
          emit(StockAdjusted("Stock adjusted successfully", product));
          add(LoadStockItems());
        },
      );
    });

    on<LoadStockHistoryEvent>((event, emit) async {
      emit(StockLoading());
      final result = await getStockHistory(event.productId);
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (history) => emit(StockHistoryLoaded(history)),
      );
    });
  }
}
