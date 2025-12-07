// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/work_order_service.dart';
import '../../../service/data/models/service_model.dart';
import 'dart:convert';

part 'work_order_service_model.freezed.dart';
part 'work_order_service_model.g.dart';

WorkOrderServiceModel workOrderServiceModelFromJson(String str) =>
    WorkOrderServiceModel.fromJson(json.decode(str));

String workOrderServiceModelToJson(WorkOrderServiceModel data) =>
    json.encode(data.toJson());

@freezed
abstract class WorkOrderServiceModel with _$WorkOrderServiceModel {
  const WorkOrderServiceModel._();

  const factory WorkOrderServiceModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "workOrderId") required String workOrderId,
    @JsonKey(name: "serviceId") required String serviceId,
    @JsonKey(name: "quantity") required int quantity,
    @JsonKey(name: "priceAtOrder") required int priceAtOrder,
    @JsonKey(name: "subtotal") required int subtotal,
    @JsonKey(name: "service") ServiceModel? serviceModel,
  }) = _WorkOrderServiceModel;

  factory WorkOrderServiceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderServiceModelFromJson(json);

  WorkOrderService toEntity() => WorkOrderService(
        id: id,
        workOrderId: workOrderId,
        serviceId: serviceId,
        quantity: quantity,
        priceAtOrder: priceAtOrder,
        subtotal: subtotal,
        service: serviceModel?.toEntity(),
      );
}
