import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class GetServicesParams extends Equatable {
  final bool isPrototype;
  final String? type;
  final PaginationParams? pagination;

  const GetServicesParams({
    this.isPrototype = false,
    this.type,
    this.pagination,
  });

  @override
  List<Object?> get props => [isPrototype, type, pagination];
}

class GetServices implements UseCase<PaginatedResponse<ServiceEntity>, GetServicesParams> {
  final ServiceRepository repository;
  GetServices(this.repository);
  @override
  Future<Either<Failure, PaginatedResponse<ServiceEntity>>> call(GetServicesParams params) async {
    return await repository.getServices(
      isPrototype: params.isPrototype,
      type: params.type,
      pagination: params.pagination,
    );
  }
}

class CreateService implements UseCase<ServiceEntity, ServiceEntity> {
  final ServiceRepository repository;
  CreateService(this.repository);
  @override
  Future<Either<Failure, ServiceEntity>> call(ServiceEntity params) async {
    return await repository.createService(params);
  }
}

class UpdateService implements UseCase<ServiceEntity, UpdateServiceParams> {
  final ServiceRepository repository;
  UpdateService(this.repository);
  @override
  Future<Either<Failure, ServiceEntity>> call(UpdateServiceParams params) async {
    return await repository.updateService(params.id, params.service);
  }
}

class UpdateServiceParams extends Equatable {
  final String id;
  final ServiceEntity service;

  const UpdateServiceParams({required this.id, required this.service});

  @override
  List<Object> get props => [id, service];
}

class DeleteService implements UseCase<void, String> {
  final ServiceRepository repository;
  DeleteService(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteService(params);
  }
}
