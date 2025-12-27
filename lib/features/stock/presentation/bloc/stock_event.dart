part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class LoadStockItems extends StockEvent {}

class SearchStockItemsEvent extends StockEvent {
  final String query;

  const SearchStockItemsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ChangePageEvent extends StockEvent {
  final int page;

  const ChangePageEvent(this.page);

  @override
  List<Object> get props => [page];
}

class ChangeItemsPerPageEvent extends StockEvent {
  final int itemsPerPage;
  const ChangeItemsPerPageEvent(this.itemsPerPage);
  @override
  List<Object> get props => [itemsPerPage];
}

class AdjustStockEvent extends StockEvent {
  final StockAdjustment adjustment;

  const AdjustStockEvent(this.adjustment);

  @override
  List<Object> get props => [adjustment];
}

class LoadStockHistoryEvent extends StockEvent {
  final String productId;

  const LoadStockHistoryEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
