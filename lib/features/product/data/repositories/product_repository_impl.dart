import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResponse<Product>>> getProducts({
    String? type,
    PaginationParams? pagination,
  }) async {
    try {
      final result = await remoteDataSource.getProducts(
        type: type,
        pagination: pagination,
      );
      return Right(result.toEntity((model) => model.toEntity()));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final model = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        type: product.type,
        stock: product.stock,
        isAvailable: product.isAvailable,
      );
      final result = await remoteDataSource.createProduct(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final model = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        type: product.type,
        stock: product.stock,
        isAvailable: product.isAvailable,
      );
      final result = await remoteDataSource.updateProduct(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
