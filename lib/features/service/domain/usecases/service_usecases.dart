import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class GetServicesParams extends Equatable {
  final bool isPrototype;
  final String? type;

  const GetServicesParams({this.isPrototype = false, this.type});

  @override
  List<Object?> get props => [isPrototype, type];
}

class GetServices implements UseCase<List<ServiceEntity>, GetServicesParams> {
  final ServiceRepository repository;
  GetServices(this.repository);
  @override
  Future<Either<Failure, List<ServiceEntity>>> call(GetServicesParams params) async {
    return await repository.getServices(isPrototype: params.isPrototype, type: params.type);
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

class DeleteService implements UseCase<void, String> {
  final ServiceRepository repository;
  DeleteService(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteService(params);
  }
}
