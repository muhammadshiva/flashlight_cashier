// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/report_data.dart';

part 'report_data_model.freezed.dart';
part 'report_data_model.g.dart';

@freezed
abstract class ReportDataModel with _$ReportDataModel {
  const ReportDataModel._();

  const factory ReportDataModel({
    @JsonKey(name: 'totalRevenue') required int totalRevenue,
    @JsonKey(name: 'totalOrders') required int totalOrders,
    @JsonKey(name: 'ordersByStatus') required Map<String, int> ordersByStatus,
    @JsonKey(name: 'topCustomers') required List<TopCustomerModel> topCustomers,
    @JsonKey(name: 'popularServices')
    required List<PopularServiceModel> popularServices,
  }) = _ReportDataModel;

  factory ReportDataModel.fromJson(Map<String, dynamic> json) =>
      _$ReportDataModelFromJson(json);

  ReportData toEntity() => ReportData(
        totalRevenue: totalRevenue,
        totalOrders: totalOrders,
        ordersByStatus: ordersByStatus,
        topCustomers: topCustomers.map((e) => e.toEntity()).toList(),
        popularServices: popularServices.map((e) => e.toEntity()).toList(),
      );
}

@freezed
abstract class TopCustomerModel with _$TopCustomerModel {
  const TopCustomerModel._();

  const factory TopCustomerModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'totalSpent') required int totalSpent,
    @JsonKey(name: 'orderCount') required int orderCount,
  }) = _TopCustomerModel;

  factory TopCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$TopCustomerModelFromJson(json);

  TopCustomer toEntity() => TopCustomer(
        id: id,
        name: name,
        totalSpent: totalSpent,
        orderCount: orderCount,
      );
}

@freezed
abstract class PopularServiceModel with _$PopularServiceModel {
  const PopularServiceModel._();

  const factory PopularServiceModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'orderCount') required int orderCount,
    @JsonKey(name: 'totalRevenue') required int totalRevenue,
  }) = _PopularServiceModel;

  factory PopularServiceModel.fromJson(Map<String, dynamic> json) =>
      _$PopularServiceModelFromJson(json);

  PopularService toEntity() => PopularService(
        id: id,
        name: name,
        orderCount: orderCount,
        totalRevenue: totalRevenue,
      );
}
