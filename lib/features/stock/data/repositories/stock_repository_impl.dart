import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/entities/stock_adjustment.dart';
import '../../domain/repositories/stock_repository.dart';
import '../datasources/stock_remote_data_source.dart';
import '../models/stock_adjustment_model.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteDataSource remoteDataSource;

  StockRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getStockItems() async {
    try {
      final result = await remoteDataSource.getStockItems();
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> adjustStock(StockAdjustment adjustment) async {
    try {
      final model = StockAdjustmentModel.fromEntity(adjustment);
      final result = await remoteDataSource.adjustStock(model);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StockAdjustment>>> getStockHistory(String productId) async {
    try {
      final result = await remoteDataSource.getStockHistory(productId);
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
