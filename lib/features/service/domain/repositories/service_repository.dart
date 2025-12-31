import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/service_entity.dart';

/// Abstract repository interface for service operations.
abstract class ServiceRepository {
  /// Gets paginated list of services.
  Future<Either<Failure, PaginatedResponse<ServiceEntity>>> getServices({
    String? type,
    PaginationParams? pagination,
  });

  /// Creates a new service.
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);

  /// Updates an existing service.
  Future<Either<Failure, ServiceEntity>> updateService(String id, ServiceEntity service);

  /// Deletes a service by id.
  Future<Either<Failure, void>> deleteService(String id);
}
