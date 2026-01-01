import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/member_vehicle_model.dart';

/// Abstract interface for member vehicle remote data operations.
abstract class MemberVehicleRemoteDataSource {
  /// Gets all member vehicles from the API.
  Future<List<MemberVehicleModel>> getMemberVehicles();

  /// Creates a new member vehicle via the API.
  Future<MemberVehicleModel> createMemberVehicle(MemberVehicleModel vehicle);

  /// Updates an existing member vehicle via the API.
  Future<MemberVehicleModel> updateMemberVehicle(MemberVehicleModel vehicle);

  /// Deletes a member vehicle by ID via the API.
  Future<void> deleteMemberVehicle(String id);
}

/// Implementation of [MemberVehicleRemoteDataSource] using Dio.
class MemberVehicleRemoteDataSourceImpl
    implements MemberVehicleRemoteDataSource {
  final Dio dio;

  MemberVehicleRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MemberVehicleModel>> getMemberVehicles() async {
    try {
      final response = await dio.get('/member/vehicles');

      // Handle API envelope: { success, message, data: [...], error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];

          if (data is Map<String, dynamic> &&
              data.containsKey('memberVehicles')) {
            final dataList = data['memberVehicles'] as List;
            return dataList
                .map((e) =>
                    MemberVehicleModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }

          // Fallback if data is directly a list
          if (data is List) {
            return data
                .map((e) =>
                    MemberVehicleModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }
        }
        throw ServerFailure(
            result['message'] ?? 'Failed to fetch member vehicles');
      }

      // If response is directly a list
      if (result is List) {
        return result
            .map((e) => MemberVehicleModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
          e.response?.data?['message'] ?? e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<MemberVehicleModel> createMemberVehicle(
      MemberVehicleModel vehicle) async {
    try {
      final response = await dio.post(
        '/member/vehicles',
        data: {
          'membershipId': vehicle.membershipId,
          'name': vehicle.name,
          'plateNumber': vehicle.plateNumber,
          'specs': vehicle.specs,
          'icon': vehicle.icon,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result.containsKey('data') && result['data'] != null) {
          return MemberVehicleModel.fromJson(
              result['data'] as Map<String, dynamic>);
        }
        // If no data key, assume the result itself is the vehicle data
        if (result.containsKey('id')) {
          return MemberVehicleModel.fromJson(result);
        }
        throw ServerFailure(
            result['message'] ?? 'Failed to create member vehicle');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
          e.response?.data?['message'] ?? e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<MemberVehicleModel> updateMemberVehicle(
      MemberVehicleModel vehicle) async {
    try {
      final response = await dio.put(
        '/member/vehicles/${vehicle.id}',
        data: {
          'name': vehicle.name,
          'plateNumber': vehicle.plateNumber,
          'specs': vehicle.specs,
          'icon': vehicle.icon,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result.containsKey('data') && result['data'] != null) {
          return MemberVehicleModel.fromJson(
              result['data'] as Map<String, dynamic>);
        }
        // If no data key, assume the result itself is the vehicle data
        if (result.containsKey('id')) {
          return MemberVehicleModel.fromJson(result);
        }
        throw ServerFailure(
            result['message'] ?? 'Failed to update member vehicle');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
          e.response?.data?['message'] ?? e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteMemberVehicle(String id) async {
    try {
      await dio.delete('/member/vehicles/$id');
    } on DioException catch (e) {
      throw ServerFailure(
          e.response?.data?['message'] ?? e.message ?? 'Unknown Error');
    }
  }
}
