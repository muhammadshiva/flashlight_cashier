import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/work_order_service.dart';
import '../../../service/data/models/service_model.dart';

WorkOrderServiceModel workOrderServiceModelFromJson(String str) =>
    WorkOrderServiceModel.fromJson(json.decode(str));

String workOrderServiceModelToJson(WorkOrderServiceModel data) =>
    json.encode(data.toJson());

class WorkOrderServiceModel extends Equatable {
  final String id;
  final String workOrderId;
  final String serviceId;
  final int quantity;
  final int priceAtOrder;
  final int subtotal;
  final ServiceModel? serviceModel;

  const WorkOrderServiceModel({
    required this.id,
    required this.workOrderId,
    required this.serviceId,
    required this.quantity,
    required this.priceAtOrder,
    required this.subtotal,
    this.serviceModel,
  });

  factory WorkOrderServiceModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderServiceModel(
        id: json["id"] as String,
        workOrderId: json["workOrderId"] as String,
        serviceId: json["serviceId"] as String,
        quantity: json["quantity"] as int,
        priceAtOrder: json["priceAtOrder"] as int,
        subtotal: json["subtotal"] as int,
        serviceModel: json["service"] != null
            ? ServiceModel.fromJson(json["service"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workOrderId": workOrderId,
        "serviceId": serviceId,
        "quantity": quantity,
        "priceAtOrder": priceAtOrder,
        "subtotal": subtotal,
        if (serviceModel != null) "service": serviceModel!.toJson(),
      };

  WorkOrderServiceModel copyWith({
    String? id,
    String? workOrderId,
    String? serviceId,
    int? quantity,
    int? priceAtOrder,
    int? subtotal,
    ServiceModel? serviceModel,
  }) {
    return WorkOrderServiceModel(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      serviceId: serviceId ?? this.serviceId,
      quantity: quantity ?? this.quantity,
      priceAtOrder: priceAtOrder ?? this.priceAtOrder,
      subtotal: subtotal ?? this.subtotal,
      serviceModel: serviceModel ?? this.serviceModel,
    );
  }

  WorkOrderService toEntity() => WorkOrderService(
        id: id,
        workOrderId: workOrderId,
        serviceId: serviceId,
        quantity: quantity,
        priceAtOrder: priceAtOrder,
        subtotal: subtotal,
        service: serviceModel?.toEntity(),
      );

  @override
  List<Object?> get props => [
        id,
        workOrderId,
        serviceId,
        quantity,
        priceAtOrder,
        subtotal,
        serviceModel,
      ];
}
