import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/work_order_product.dart';
import '../../../product/data/models/product_model.dart';

WorkOrderProductModel workOrderProductModelFromJson(String str) =>
    WorkOrderProductModel.fromJson(json.decode(str));

String workOrderProductModelToJson(WorkOrderProductModel data) =>
    json.encode(data.toJson());

class WorkOrderProductModel extends Equatable {
  final String id;
  final String workOrderId;
  final String productId;
  final int quantity;
  final int priceAtOrder;
  final int subtotal;
  final ProductModel? productModel;

  const WorkOrderProductModel({
    required this.id,
    required this.workOrderId,
    required this.productId,
    required this.quantity,
    required this.priceAtOrder,
    required this.subtotal,
    this.productModel,
  });

  factory WorkOrderProductModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderProductModel(
        id: json["id"] as String,
        workOrderId: json["workOrderId"] as String,
        productId: json["productId"] as String,
        quantity: json["quantity"] as int,
        priceAtOrder: json["priceAtOrder"] as int,
        subtotal: json["subtotal"] as int,
        productModel: json["product"] != null
            ? ProductModel.fromJson(json["product"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workOrderId": workOrderId,
        "productId": productId,
        "quantity": quantity,
        "priceAtOrder": priceAtOrder,
        "subtotal": subtotal,
        if (productModel != null) "product": productModel!.toJson(),
      };

  WorkOrderProductModel copyWith({
    String? id,
    String? workOrderId,
    String? productId,
    int? quantity,
    int? priceAtOrder,
    int? subtotal,
    ProductModel? productModel,
  }) {
    return WorkOrderProductModel(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      priceAtOrder: priceAtOrder ?? this.priceAtOrder,
      subtotal: subtotal ?? this.subtotal,
      productModel: productModel ?? this.productModel,
    );
  }

  WorkOrderProduct toEntity() => WorkOrderProduct(
        id: id,
        workOrderId: workOrderId,
        productId: productId,
        quantity: quantity,
        priceAtOrder: priceAtOrder,
        subtotal: subtotal,
        product: productModel?.toEntity(),
      );

  @override
  List<Object?> get props => [
        id,
        workOrderId,
        productId,
        quantity,
        priceAtOrder,
        subtotal,
        productModel,
      ];
}
