// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/work_order_product.dart';
import '../../../product/data/models/product_model.dart';
import 'dart:convert';

part 'work_order_product_model.freezed.dart';
part 'work_order_product_model.g.dart';

WorkOrderProductModel workOrderProductModelFromJson(String str) =>
    WorkOrderProductModel.fromJson(json.decode(str));

String workOrderProductModelToJson(WorkOrderProductModel data) =>
    json.encode(data.toJson());

@freezed
abstract class WorkOrderProductModel with _$WorkOrderProductModel {
  const WorkOrderProductModel._();

  const factory WorkOrderProductModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "workOrderId") required String workOrderId,
    @JsonKey(name: "productId") required String productId,
    @JsonKey(name: "quantity") required int quantity,
    @JsonKey(name: "priceAtOrder") required int priceAtOrder,
    @JsonKey(name: "subtotal") required int subtotal,
    @JsonKey(name: "product") ProductModel? productModel,
  }) = _WorkOrderProductModel;

  factory WorkOrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderProductModelFromJson(json);

  WorkOrderProduct toEntity() => WorkOrderProduct(
        id: id,
        workOrderId: workOrderId,
        productId: productId,
        quantity: quantity,
        priceAtOrder: priceAtOrder,
        subtotal: subtotal,
        product: productModel?.toEntity(),
      );
}
