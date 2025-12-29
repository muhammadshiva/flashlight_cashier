// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dashboard_stats.dart';
import 'dart:convert';

part 'dashboard_stats_model.freezed.dart';
part 'dashboard_stats_model.g.dart';

DashboardStatsModel dashboardStatsModelFromJson(String str) =>
    DashboardStatsModel.fromJson(json.decode(str));

String dashboardStatsModelToJson(DashboardStatsModel data) =>
    json.encode(data.toJson());

@freezed
abstract class DashboardStatsModel with _$DashboardStatsModel {
  const DashboardStatsModel._();

  const factory DashboardStatsModel({
    @JsonKey(name: "totalOrders") required int totalOrders,
    @JsonKey(name: "totalRevenue") required int totalRevenue,
    @JsonKey(name: "pendingOrders") required int pendingOrders,
    @JsonKey(name: "inProgressOrders") required int inProgressOrders,
    @JsonKey(name: "completedOrders") required int completedOrders,
    @JsonKey(name: "cancelledOrders") required int cancelledOrders,
    @JsonKey(name: "statusCounts") required Map<String, int> statusCounts,
  }) = _DashboardStatsModel;

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  DashboardStats toEntity() => DashboardStats(
        totalOrders: totalOrders,
        totalRevenue: totalRevenue,
        pendingOrders: pendingOrders,
        inProgressOrders: inProgressOrders,
        completedOrders: completedOrders,
        cancelledOrders: cancelledOrders,
        statusCounts: statusCounts,
      );
}
