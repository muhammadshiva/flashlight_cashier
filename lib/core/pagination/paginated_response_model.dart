// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'paginated_response.dart';

part 'paginated_response_model.freezed.dart';
part 'paginated_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PaginatedResponseModel<T> with _$PaginatedResponseModel<T> {
  const PaginatedResponseModel._();

  const factory PaginatedResponseModel({
    @JsonKey(name: 'data') required List<T> data,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'limit') required int limit,
    @JsonKey(name: 'totalPages') required int totalPages,
  }) = _PaginatedResponseModel<T>;

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResponseModelFromJson(json, fromJsonT);

  PaginatedResponse<R> toEntity<R>(R Function(T) converter) =>
      PaginatedResponse<R>(
        data: data.map(converter).toList(),
        total: total,
        page: page,
        limit: limit,
        totalPages: totalPages,
      );
}
