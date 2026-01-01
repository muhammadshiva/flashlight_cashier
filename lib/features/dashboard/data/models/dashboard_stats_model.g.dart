// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    _DashboardStatsModel(
      totalWorkOrders: (json['totalWorkOrders'] as num?)?.toInt(),
      totalOrders: (json['totalOrders'] as num?)?.toInt(),
      totalRevenue: (json['totalRevenue'] as num?)?.toInt() ?? 0,
      totalCustomers: (json['totalCustomers'] as num?)?.toInt(),
      activeMembers: (json['activeMembers'] as num?)?.toInt(),
      todayOrders: (json['todayOrders'] as num?)?.toInt(),
      pendingOrders: (json['pendingOrders'] as num?)?.toInt() ?? 0,
      inProgressOrders: (json['inProgressOrders'] as num?)?.toInt() ?? 0,
      completedOrders: (json['completedOrders'] as num?)?.toInt() ?? 0,
      cancelledOrders: (json['cancelledOrders'] as num?)?.toInt() ?? 0,
      statusCounts: (json['statusCounts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
        _DashboardStatsModel instance) =>
    <String, dynamic>{
      'totalWorkOrders': instance.totalWorkOrders,
      'totalOrders': instance.totalOrders,
      'totalRevenue': instance.totalRevenue,
      'totalCustomers': instance.totalCustomers,
      'activeMembers': instance.activeMembers,
      'todayOrders': instance.todayOrders,
      'pendingOrders': instance.pendingOrders,
      'inProgressOrders': instance.inProgressOrders,
      'completedOrders': instance.completedOrders,
      'cancelledOrders': instance.cancelledOrders,
      'statusCounts': instance.statusCounts,
    };
