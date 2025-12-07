import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/vehicle_model.dart';

abstract class VehicleRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();
  Future<VehicleModel> createVehicle(VehicleModel vehicle);
  Future<void> deleteVehicle(String id);
}

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final Dio dio;

  VehicleRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<VehicleModel>> getVehicles() async {
    try {
      final response = await dio.get('/vehicles');
      return (response.data as List)
          .map((e) => VehicleModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<VehicleModel> createVehicle(VehicleModel vehicle) async {
    try {
      final response = await dio.post('/vehicles', data: vehicle.toJson());
      return VehicleModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteVehicle(String id) async {
    try {
      await dio.delete('/vehicles/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
