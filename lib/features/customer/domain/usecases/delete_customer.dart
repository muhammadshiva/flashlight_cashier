import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/customer_repository.dart';

class DeleteCustomer implements UseCase<void, DeleteCustomerParams> {
  final CustomerRepository repository;

  DeleteCustomer(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteCustomerParams params) async {
    return await repository.deleteCustomer(params.id);
  }
}

class DeleteCustomerParams extends Equatable {
  final String id;

  const DeleteCustomerParams({required this.id});

  @override
  List<Object> get props => [id];
}
