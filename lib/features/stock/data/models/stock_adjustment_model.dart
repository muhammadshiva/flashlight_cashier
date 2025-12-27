// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/stock_adjustment.dart';

part 'stock_adjustment_model.freezed.dart';
part 'stock_adjustment_model.g.dart';

@freezed
abstract class StockAdjustmentModel with _$StockAdjustmentModel {
  const StockAdjustmentModel._();

  const factory StockAdjustmentModel({
    @JsonKey(name: "product_id") required String productId,
    @JsonKey(name: "quantity") required int quantity,
    @JsonKey(name: "type") required String type,
    @JsonKey(name: "reason") required String reason,
    @JsonKey(name: "timestamp") required DateTime timestamp,
  }) = _StockAdjustmentModel;

  factory StockAdjustmentModel.fromJson(Map<String, dynamic> json) =>
      _$StockAdjustmentModelFromJson(json);

  StockAdjustment toEntity() {
    return StockAdjustment(
      productId: productId,
      quantity: quantity,
      type: type == 'addition' ? AdjustmentType.addition : AdjustmentType.reduction,
      reason: reason,
      timestamp: timestamp,
    );
  }

  factory StockAdjustmentModel.fromEntity(StockAdjustment adjustment) {
    return StockAdjustmentModel(
      productId: adjustment.productId,
      quantity: adjustment.quantity,
      type: adjustment.type == AdjustmentType.addition ? 'addition' : 'reduction',
      reason: adjustment.reason,
      timestamp: adjustment.timestamp,
    );
  }
}
