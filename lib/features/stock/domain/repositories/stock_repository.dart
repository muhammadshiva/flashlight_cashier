import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../product/domain/entities/product.dart';
import '../entities/stock_adjustment.dart';

abstract class StockRepository {
  Future<Either<Failure, List<Product>>> getStockItems();
  Future<Either<Failure, Product>> adjustStock(StockAdjustment adjustment);
  Future<Either<Failure, List<StockAdjustment>>> getStockHistory(String productId);
}
