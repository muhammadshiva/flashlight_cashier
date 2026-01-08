// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/dashboard_stats.dart';

DashboardStatsModel dashboardStatsModelFromJson(String str) =>
    DashboardStatsModel.fromJson(json.decode(str));

String dashboardStatsModelToJson(DashboardStatsModel data) => json.encode(data.toJson());

class DashboardStatsModel extends Equatable {
  final int? totalWorkOrders;
  final int? totalOrders;
  final int totalRevenue;
  final int? totalCustomers;
  final int? activeMembers;
  final int? todayOrders;
  final int pendingOrders;
  final int inProgressOrders;
  final int completedOrders;
  final int cancelledOrders;
  final Map<String, int>? statusCounts;

  const DashboardStatsModel({
    this.totalWorkOrders,
    this.totalOrders,
    this.totalRevenue = 0,
    this.totalCustomers,
    this.activeMembers,
    this.todayOrders,
    this.pendingOrders = 0,
    this.inProgressOrders = 0,
    this.completedOrders = 0,
    this.cancelledOrders = 0,
    this.statusCounts,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) => DashboardStatsModel(
        totalWorkOrders: json["totalWorkOrders"] as int?,
        totalOrders: json["totalOrders"] as int?,
        totalRevenue: json["totalRevenue"] as int? ?? 0,
        totalCustomers: json["totalCustomers"] as int?,
        activeMembers: json["activeMembers"] as int?,
        todayOrders: json["todayOrders"] as int?,
        pendingOrders: json["pendingOrders"] as int? ?? 0,
        inProgressOrders: json["inProgressOrders"] as int? ?? 0,
        completedOrders: json["completedOrders"] as int? ?? 0,
        cancelledOrders: json["cancelledOrders"] as int? ?? 0,
        statusCounts: json["statusCounts"] != null
            ? Map<String, int>.from(json["statusCounts"] as Map)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "totalWorkOrders": totalWorkOrders,
        "totalOrders": totalOrders,
        "totalRevenue": totalRevenue,
        "totalCustomers": totalCustomers,
        "activeMembers": activeMembers,
        "todayOrders": todayOrders,
        "pendingOrders": pendingOrders,
        "inProgressOrders": inProgressOrders,
        "completedOrders": completedOrders,
        "cancelledOrders": cancelledOrders,
        "statusCounts": statusCounts,
      };

  DashboardStats toEntity() => DashboardStats(
        totalOrders: totalWorkOrders ?? totalOrders ?? 0,
        totalRevenue: totalRevenue,
        pendingOrders: pendingOrders,
        inProgressOrders: inProgressOrders,
        completedOrders: completedOrders,
        cancelledOrders: cancelledOrders,
        statusCounts: statusCounts ?? {},
      );

  /// Prototype/dummy data for testing and development
  static DashboardStatsModel get prototypeData => const DashboardStatsModel(
        totalWorkOrders: 45,
        totalOrders: 45,
        totalRevenue: 12500000, // Rp 12.500.000
        totalCustomers: 120,
        activeMembers: 35,
        todayOrders: 8,
        pendingOrders: 5,
        inProgressOrders: 12,
        completedOrders: 25,
        cancelledOrders: 3,
        statusCounts: {
          'pending': 5,
          'in_progress': 12,
          'completed': 25,
          'cancelled': 3,
        },
      );

  @override
  List<Object?> get props => [
        totalWorkOrders,
        totalOrders,
        totalRevenue,
        totalCustomers,
        activeMembers,
        todayOrders,
        pendingOrders,
        inProgressOrders,
        completedOrders,
        cancelledOrders,
        statusCounts,
      ];
}
