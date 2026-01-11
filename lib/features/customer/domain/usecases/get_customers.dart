import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class GetCustomers implements UseCase<PaginatedResponse<Customer>, GetCustomersParams> {
  final CustomerRepository repository;

  GetCustomers(this.repository);

  @override
  Future<Either<Failure, PaginatedResponse<Customer>>> call(GetCustomersParams params) async {
    return await repository.getCustomers(
      pagination: params.pagination,
      query: params.query,
    );
  }
}

class GetCustomersParams extends Equatable {
  final PaginationParams? pagination;
  final String? query;
  final bool? isPrototype;

  const GetCustomersParams({this.pagination, this.query, this.isPrototype});

  @override
  List<Object?> get props => [pagination, query, isPrototype];
}
