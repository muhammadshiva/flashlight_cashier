part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Product> stockItems;
  final List<Product> allStockItems;
  final List<Product> sourceStockItems;
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  const StockLoaded({
    required this.stockItems,
    required this.allStockItems,
    required this.sourceStockItems,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
  });

  @override
  List<Object> get props => [
        stockItems,
        allStockItems,
        sourceStockItems,
        currentPage,
        totalItems,
        itemsPerPage,
      ];
}

class StockError extends StockState {
  final String message;

  const StockError(this.message);

  @override
  List<Object> get props => [message];
}

class StockAdjusted extends StockState {
  final String message;
  final Product updatedProduct;

  const StockAdjusted(this.message, this.updatedProduct);

  @override
  List<Object> get props => [message, updatedProduct];
}

class StockHistoryLoaded extends StockState {
  final List<StockAdjustment> history;

  const StockHistoryLoaded(this.history);

  @override
  List<Object> get props => [history];
}
