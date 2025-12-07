import 'package:equatable/equatable.dart';
import '../../../product/domain/entities/product.dart';

class WorkOrderProduct extends Equatable {
  final String id;
  final String workOrderId;
  final String productId;
  final int quantity;
  final int priceAtOrder;
  final int subtotal;
  final Product? product;

  const WorkOrderProduct({
    required this.id,
    required this.workOrderId,
    required this.productId,
    required this.quantity,
    required this.priceAtOrder,
    required this.subtotal,
    this.product,
  });

  @override
  List<Object?> get props =>
      [id, workOrderId, productId, quantity, priceAtOrder, subtotal, product];
}
