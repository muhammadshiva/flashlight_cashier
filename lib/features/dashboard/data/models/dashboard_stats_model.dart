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
    @JsonKey(name: "totalWorkOrders") int? totalWorkOrders,
    @JsonKey(name: "totalOrders") int? totalOrders,
    @JsonKey(name: "totalRevenue") @Default(0) int totalRevenue,
    @JsonKey(name: "totalCustomers") int? totalCustomers,
    @JsonKey(name: "activeMembers") int? activeMembers,
    @JsonKey(name: "todayOrders") int? todayOrders,
    @JsonKey(name: "pendingOrders") @Default(0) int pendingOrders,
    @JsonKey(name: "inProgressOrders") @Default(0) int inProgressOrders,
    @JsonKey(name: "completedOrders") @Default(0) int completedOrders,
    @JsonKey(name: "cancelledOrders") @Default(0) int cancelledOrders,
    @JsonKey(name: "statusCounts") Map<String, int>? statusCounts,
  }) = _DashboardStatsModel;

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  DashboardStats toEntity() => DashboardStats(
        totalOrders: totalWorkOrders ?? totalOrders ?? 0,
        totalRevenue: totalRevenue,
        pendingOrders: pendingOrders,
        inProgressOrders: inProgressOrders,
        completedOrders: completedOrders,
        cancelledOrders: cancelledOrders,
        statusCounts: statusCounts ?? {},
      );
}
