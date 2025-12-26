import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategories implements UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;
  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}

class CreateCategory implements UseCase<Category, Category> {
  final CategoryRepository repository;
  CreateCategory(this.repository);

  @override
  Future<Either<Failure, Category>> call(Category params) async {
    return await repository.createCategory(params);
  }
}

class UpdateCategory implements UseCase<Category, Category> {
  final CategoryRepository repository;
  UpdateCategory(this.repository);

  @override
  Future<Either<Failure, Category>> call(Category params) async {
    return await repository.updateCategory(params);
  }
}

class DeleteCategory implements UseCase<void, String> {
  final CategoryRepository repository;
  DeleteCategory(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteCategory(params);
  }
}
