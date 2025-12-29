import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/service_entity.dart';

abstract class ServiceRepository {
  Future<Either<Failure, PaginatedResponse<ServiceEntity>>> getServices({
    bool isPrototype = false,
    String? type,
    PaginationParams? pagination,
  });
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);
  Future<Either<Failure, ServiceEntity>> updateService(String id, ServiceEntity service);
  Future<Either<Failure, void>> deleteService(String id);
}
