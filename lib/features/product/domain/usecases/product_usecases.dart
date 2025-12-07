import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;
  GetProducts(this.repository);
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
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
