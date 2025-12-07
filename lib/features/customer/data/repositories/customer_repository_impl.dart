import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_data_source.dart';
import '../models/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Customer>>> getCustomers() async {
    try {
      final result = await remoteDataSource.getCustomers();
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Customer>> createCustomer(Customer customer) async {
    try {
      final customerModel = CustomerModel(
        id: customer.id,
        name: customer.name,
        phoneNumber: customer.phoneNumber,
        email: customer.email,
      );
      final result = await remoteDataSource.createCustomer(customerModel);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Customer>> updateCustomer(Customer customer) async {
    try {
      final customerModel = CustomerModel(
        id: customer.id,
        name: customer.name,
        phoneNumber: customer.phoneNumber,
        email: customer.email,
      );
      final result = await remoteDataSource.updateCustomer(customerModel);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCustomer(String id) async {
    try {
      await remoteDataSource.deleteCustomer(id);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
