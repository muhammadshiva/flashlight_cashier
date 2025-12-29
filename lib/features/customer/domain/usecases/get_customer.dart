import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class GetCustomer implements UseCase<Customer, String> {
  final CustomerRepository repository;

  GetCustomer(this.repository);

  @override
  Future<Either<Failure, Customer>> call(String id) async {
    return await repository.getCustomer(id);
  }
}
