import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../models/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServices({bool isPrototype = false});
  Future<ServiceModel> createService(ServiceModel service);
  Future<void> deleteService(String id);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final Dio dio;

  ServiceRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ServiceModel>> getServices({bool isPrototype = false}) async {
    try {
      if (isPrototype) {
        return ServiceResponseModel.getPrototypeDataServices;
      }

      final response = await dio.get('/services');
      return (response.data as List).map((e) => ServiceModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<ServiceModel> createService(ServiceModel service) async {
    try {
      final response = await dio.post('/services', data: service.toJson());
      return ServiceModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteService(String id) async {
    try {
      await dio.delete('/services/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
