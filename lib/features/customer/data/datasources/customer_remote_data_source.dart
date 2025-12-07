import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<List<CustomerModel>> getCustomers();
  Future<CustomerModel> createCustomer(CustomerModel customer);
  Future<CustomerModel> updateCustomer(CustomerModel customer);
  Future<void> deleteCustomer(String id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Dio dio;

  CustomerRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CustomerModel>> getCustomers() async {
    try {
      final response = await dio.get('/customers');
      return (response.data as List)
          .map((e) => CustomerModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<CustomerModel> createCustomer(CustomerModel customer) async {
    try {
      final response = await dio.post(
        '/customers',
        data: customer.toJson(),
      );
      return CustomerModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<CustomerModel> updateCustomer(CustomerModel customer) async {
    try {
      final response = await dio.put(
        '/customers/${customer.id}',
        data: customer.toJson(),
      );
      return CustomerModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteCustomer(String id) async {
    try {
      await dio.delete('/customers/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
