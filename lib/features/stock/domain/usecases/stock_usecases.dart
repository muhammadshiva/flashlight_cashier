import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../product/domain/entities/product.dart';
import '../entities/stock_adjustment.dart';
import '../repositories/stock_repository.dart';

class GetStockItems implements UseCase<List<Product>, NoParams> {
  final StockRepository repository;
  GetStockItems(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getStockItems();
  }
}

class AdjustStock implements UseCase<Product, StockAdjustment> {
  final StockRepository repository;
  AdjustStock(this.repository);

  @override
  Future<Either<Failure, Product>> call(StockAdjustment params) async {
    return await repository.adjustStock(params);
  }
}

class GetStockHistory implements UseCase<List<StockAdjustment>, String> {
  final StockRepository repository;
  GetStockHistory(this.repository);

  @override
  Future<Either<Failure, List<StockAdjustment>>> call(String params) async {
    return await repository.getStockHistory(params);
  }
}
