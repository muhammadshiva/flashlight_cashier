import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistory extends HistoryEvent {}

class RefreshHistory extends HistoryEvent {}

class FilterHistory extends HistoryEvent {
  final String? status;
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  const FilterHistory({
    this.status,
    this.searchQuery,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object> get props => [
        if (status != null) status!,
        if (searchQuery != null) searchQuery!,
        if (startDate != null) startDate!,
        if (endDate != null) endDate!,
      ];
}

class ChangePageEvent extends HistoryEvent {
  final int page;

  const ChangePageEvent(this.page);

  @override
  List<Object> get props => [page];
}
