import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/vehicle_model.dart';

/// Abstract interface for vehicle remote data operations.
abstract class VehicleRemoteDataSource {
  /// Gets all vehicles from the API.
  Future<List<VehicleModel>> getVehicles();

  /// Creates a new vehicle via the API.
  Future<VehicleModel> createVehicle(VehicleModel vehicle);

  /// Updates an existing vehicle via the API.
  Future<VehicleModel> updateVehicle(VehicleModel vehicle);

  /// Deletes a vehicle by [id] via the API.
  Future<void> deleteVehicle(String id);
}

/// Implementation of [VehicleRemoteDataSource] using Dio.
class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final Dio dio;

  VehicleRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<VehicleModel>> getVehicles() async {
    try {
      final response = await dio.get('/vehicles');

      // Handle API envelope: { success, message, data: { vehicles: [...], total }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          final vehiclesList = data['vehicles'] as List;
          return vehiclesList
              .map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch vehicles');
      }

      // If response is directly a list (fallback for different API formats)
      if (result is List) {
        return result
            .map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<VehicleModel> createVehicle(VehicleModel vehicle) async {
    try {
      final response = await dio.post(
        '/vehicles',
        data: {
          'customerId': vehicle.customerId,
          'model': vehicle.vehicleBrand,
          'licensePlate': vehicle.licensePlate,
          'category': vehicle.vehicleCategory,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return VehicleModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the vehicle
        if (result.containsKey('id')) {
          return VehicleModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to create vehicle');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<VehicleModel> updateVehicle(VehicleModel vehicle) async {
    try {
      final response = await dio.put(
        '/vehicles/${vehicle.id}',
        data: {
          'model': vehicle.vehicleBrand,
          'licensePlate': vehicle.licensePlate,
          'category': vehicle.vehicleCategory,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return VehicleModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the vehicle
        if (result.containsKey('id')) {
          return VehicleModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update vehicle');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<void> deleteVehicle(String id) async {
    try {
      final response = await dio.delete('/vehicles/$id');

      // Handle API envelope: { success, message, data: null, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] != true) {
          throw ServerFailure(result['message'] ?? 'Failed to delete vehicle');
        }
      }
      // If response is empty or success, return normally
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }
}
