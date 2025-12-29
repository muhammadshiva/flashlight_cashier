import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../entities/customer.dart';

abstract class CustomerRepository {
  Future<Either<Failure, PaginatedResponse<Customer>>> getCustomers({
    PaginationParams? pagination,
    String? query,
  });
  Future<Either<Failure, Customer>> getCustomer(String id);
  Future<Either<Failure, Customer>> createCustomer(Customer customer);
  Future<Either<Failure, Customer>> updateCustomer(Customer customer);
  Future<Either<Failure, void>> deleteCustomer(String id);
}
