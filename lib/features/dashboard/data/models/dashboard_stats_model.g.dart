// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    _DashboardStatsModel(
      totalOrders: (json['totalOrders'] as num).toInt(),
      totalRevenue: (json['totalRevenue'] as num).toInt(),
      pendingOrders: (json['pendingOrders'] as num).toInt(),
      inProgressOrders: (json['inProgressOrders'] as num).toInt(),
      completedOrders: (json['completedOrders'] as num).toInt(),
      cancelledOrders: (json['cancelledOrders'] as num).toInt(),
      statusCounts: Map<String, int>.from(json['statusCounts'] as Map),
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
        _DashboardStatsModel instance) =>
    <String, dynamic>{
      'totalOrders': instance.totalOrders,
      'totalRevenue': instance.totalRevenue,
      'pendingOrders': instance.pendingOrders,
      'inProgressOrders': instance.inProgressOrders,
      'completedOrders': instance.completedOrders,
      'cancelledOrders': instance.cancelledOrders,
      'statusCounts': instance.statusCounts,
    };
