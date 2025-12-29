import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/service_entity.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<ServiceEntity>>> getServices({bool isPrototype = false, String? type});
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);
  Future<Either<Failure, void>> deleteService(String id);
}
