import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/vehicle_model.dart';

abstract class VehicleRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();
  Future<VehicleModel> createVehicle(VehicleModel vehicle);
  Future<VehicleModel> updateVehicle(VehicleModel vehicle);
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
    } catch (e) {
      // Return generated dummy data on failure (simulating 50 items)
      return List.generate(50, (index) {
        final id = (index + 1).toString();
        // Cycle through brands to vary data
        final brands = [
          'Toyota',
          'Honda',
          'Suzuki',
          'Daihatsu',
          'Mitsubishi',
          'Nissan',
          'Mazda',
          'Isuzu',
          'BMW',
          'Mercedes'
        ];
        final brand = brands[index % brands.length];

        // Cycle through colors
        final colors = [
          'Hitam',
          'Putih',
          'Silver',
          'Merah',
          'Biru',
          'Abu-abu',
          'Hijau',
          'Kuning'
        ];
        final color = colors[index % colors.length];

        // Cycle through categories
        final categories = [
          'Sedan',
          'SUV',
          'MPV',
          'Hatchback',
          'Pickup',
          'Van'
        ];
        final category = categories[index % categories.length];

        return VehicleModel(
          id: 'VH-${id.padLeft(4, '0')}', // e.g. VH-0001
          licensePlate: 'B ${(1000 + index * 11)} ${String.fromCharCode(65 + (index % 26))}${String.fromCharCode(65 + ((index + 1) % 26))}${String.fromCharCode(65 + ((index + 2) % 26))}', // e.g. B 1234 ABC
          vehicleBrand: brand,
          vehicleColor: color,
          vehicleCategory: category,
          vehicleSpecs: '$brand $category ${2010 + (index % 15)}', // e.g. Toyota Sedan 2015
        );
      });
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
  Future<VehicleModel> updateVehicle(VehicleModel vehicle) async {
    try {
      final response =
          await dio.put('/vehicles/${vehicle.id}', data: vehicle.toJson());
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
