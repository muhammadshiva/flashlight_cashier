import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_remote_data_source.dart';
import '../models/service_model.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResponse<ServiceEntity>>> getServices({
    bool isPrototype = false,
    String? type,
    PaginationParams? pagination,
  }) async {
    try {
      final result = await remoteDataSource.getServices(
        isPrototype: isPrototype,
        type: type,
        pagination: pagination,
      );
      return Right(result.toEntity((model) => model.toEntity()));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service) async {
    try {
      final model = ServiceModel(
        id: service.id,
        name: service.name,
        description: service.description,
        price: service.price,
        imageUrl: service.imageUrl,
        isDefault: service.isDefault,
        isFavorite: service.isFavorite,
        type: service.type,
        isActive: service.isActive,
      );
      final result = await remoteDataSource.createService(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> updateService(String id, ServiceEntity service) async {
    try {
      final model = ServiceModel(
        id: service.id,
        name: service.name,
        description: service.description,
        price: service.price,
        imageUrl: service.imageUrl,
        isDefault: service.isDefault,
        isFavorite: service.isFavorite,
        type: service.type,
        isActive: service.isActive,
      );
      final result = await remoteDataSource.updateService(id, model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(String id) async {
    try {
      await remoteDataSource.deleteService(id);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
