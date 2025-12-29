import 'package:equatable/equatable.dart';

class PaginationParams extends Equatable {
  final int page;
  final int limit;
  final int? offset;

  const PaginationParams({
    this.page = 1,
    this.limit = 10,
    this.offset,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (offset != null) {
      params['offset'] = offset;
    }

    return params;
  }

  @override
  List<Object?> get props => [page, limit, offset];
}
