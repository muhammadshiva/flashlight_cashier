import 'package:equatable/equatable.dart';

enum AdjustmentType { addition, reduction }

class StockAdjustment extends Equatable {
  final String productId;
  final int quantity;
  final AdjustmentType type;
  final String reason;
  final DateTime timestamp;

  const StockAdjustment({
    required this.productId,
    required this.quantity,
    required this.type,
    required this.reason,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [productId, quantity, type, reason, timestamp];
}
