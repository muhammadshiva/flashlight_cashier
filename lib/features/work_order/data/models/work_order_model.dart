// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/work_order.dart';
import 'work_order_service_model.dart';
import 'work_order_product_model.dart';
import 'dart:convert';

part 'work_order_model.freezed.dart';
part 'work_order_model.g.dart';

WorkOrderModel workOrderModelFromJson(String str) =>
    WorkOrderModel.fromJson(json.decode(str));

String workOrderModelToJson(WorkOrderModel data) => json.encode(data.toJson());

@freezed
abstract class WorkOrderModel with _$WorkOrderModel {
  const WorkOrderModel._();

  @JsonSerializable(explicitToJson: true)
  const factory WorkOrderModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "workOrderCode") required String workOrderCode,
    @JsonKey(name: "customerId") required String customerId,
    @JsonKey(name: "vehicleDataId") required String vehicleDataId,
    @JsonKey(name: "queueNumber") required String queueNumber,
    @JsonKey(name: "estimatedTime") required String estimatedTime,
    @JsonKey(name: "status") required String status,
    @JsonKey(name: "paymentStatus") String? paymentStatus,
    @JsonKey(name: "paymentMethod") String? paymentMethod,
    @JsonKey(name: "paidAmount") @Default(0) int paidAmount,
    @JsonKey(name: "totalPrice") required int totalPrice,
    @JsonKey(name: "services")
    @Default([])
    List<WorkOrderServiceModel> serviceModels,
    @JsonKey(name: "products")
    @Default([])
    List<WorkOrderProductModel> productModels,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "completedAt") DateTime? completedAt,
  }) = _WorkOrderModel;

  factory WorkOrderModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderModelFromJson(json);

  WorkOrder toEntity() => WorkOrder(
        id: id,
        workOrderCode: workOrderCode,
        customerId: customerId,
        vehicleDataId: vehicleDataId,
        queueNumber: queueNumber,
        estimatedTime: estimatedTime,
        status: status,
        paymentStatus: paymentStatus,
        paymentMethod: paymentMethod,
        paidAmount: paidAmount,
        totalPrice: totalPrice,
        services: serviceModels.map((e) => e.toEntity()).toList(),
        products: productModels.map((e) => e.toEntity()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
        completedAt: completedAt,
      );
}

@freezed
abstract class WorkOrderResponseModel with _$WorkOrderResponseModel {
  const factory WorkOrderResponseModel({
    @JsonKey(name: "success") required bool success,
    @JsonKey(name: "message") required String message,
    @JsonKey(name: "data") required WorkOrderDataModel data,
    @JsonKey(name: "error_code") required int errorCode,
  }) = _WorkOrderResponseModel;

  factory WorkOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderResponseModelFromJson(json);
}

@freezed
abstract class WorkOrderDataModel with _$WorkOrderDataModel {
  const factory WorkOrderDataModel({
    @JsonKey(name: "workOrders") required List<WorkOrderModel> workOrders,
    @JsonKey(name: "total") required int total,
  }) = _WorkOrderDataModel;

  factory WorkOrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderDataModelFromJson(json);
}
