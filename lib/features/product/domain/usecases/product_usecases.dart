import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts implements UseCase<PaginatedResponse<Product>, GetProductsParams> {
  final ProductRepository repository;
  GetProducts(this.repository);
  @override
  Future<Either<Failure, PaginatedResponse<Product>>> call(GetProductsParams params) async {
    return await repository.getProducts(
      type: params.type,
      pagination: params.pagination,
    );
  }
}

class GetProductsParams extends Equatable {
  final String? type;
  final PaginationParams? pagination;

  const GetProductsParams({this.type, this.pagination});

  @override
  List<Object?> get props => [type, pagination];
}

class CreateProduct implements UseCase<Product, Product> {
  final ProductRepository repository;
  CreateProduct(this.repository);
  @override
  Future<Either<Failure, Product>> call(Product params) async {
    return await repository.createProduct(params);
  }
}

class DeleteProduct implements UseCase<void, String> {
  final ProductRepository repository;
  DeleteProduct(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteProduct(params);
  }
}
