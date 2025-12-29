// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportDataModel _$ReportDataModelFromJson(Map<String, dynamic> json) =>
    _ReportDataModel(
      totalRevenue: (json['totalRevenue'] as num).toInt(),
      totalOrders: (json['totalOrders'] as num).toInt(),
      ordersByStatus: Map<String, int>.from(json['ordersByStatus'] as Map),
      topCustomers: (json['topCustomers'] as List<dynamic>)
          .map((e) => TopCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularServices: (json['popularServices'] as List<dynamic>)
          .map((e) => PopularServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportDataModelToJson(_ReportDataModel instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalOrders': instance.totalOrders,
      'ordersByStatus': instance.ordersByStatus,
      'topCustomers': instance.topCustomers,
      'popularServices': instance.popularServices,
    };

_TopCustomerModel _$TopCustomerModelFromJson(Map<String, dynamic> json) =>
    _TopCustomerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      totalSpent: (json['totalSpent'] as num).toInt(),
      orderCount: (json['orderCount'] as num).toInt(),
    );

Map<String, dynamic> _$TopCustomerModelToJson(_TopCustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'totalSpent': instance.totalSpent,
      'orderCount': instance.orderCount,
    };

_PopularServiceModel _$PopularServiceModelFromJson(Map<String, dynamic> json) =>
    _PopularServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      orderCount: (json['orderCount'] as num).toInt(),
      totalRevenue: (json['totalRevenue'] as num).toInt(),
    );

Map<String, dynamic> _$PopularServiceModelToJson(
        _PopularServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'orderCount': instance.orderCount,
      'totalRevenue': instance.totalRevenue,
    };
