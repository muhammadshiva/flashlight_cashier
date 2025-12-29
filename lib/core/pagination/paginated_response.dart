import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  final List<T> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const PaginatedResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  bool get hasMore => page < totalPages;
  bool get isFirstPage => page == 1;
  bool get isLastPage => page == totalPages;

  @override
  List<Object?> get props => [data, total, page, limit, totalPages];
}
