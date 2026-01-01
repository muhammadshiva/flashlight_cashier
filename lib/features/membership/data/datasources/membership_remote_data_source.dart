import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/membership_model.dart';
import '../models/membership_status_model.dart';

/// Abstract interface for membership remote data operations.
abstract class MembershipRemoteDataSource {
  /// Gets all memberships from the API.
  Future<List<MembershipModel>> getMemberships();

  /// Creates a new membership via the API.
  Future<MembershipModel> createMembership(MembershipModel membership);

  /// Deletes a membership by [id] via the API.
  Future<void> deleteMembership(String id);

  /// Checks membership status by [phoneNumber].
  Future<MembershipStatusModel> checkMembershipStatus(String phoneNumber);

  /// Updates an existing membership via the API.
  Future<MembershipModel> updateMembership(String id, MembershipModel membership);
}

/// Implementation of [MembershipRemoteDataSource] using Dio.
class MembershipRemoteDataSourceImpl implements MembershipRemoteDataSource {
  final Dio dio;

  MembershipRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MembershipModel>> getMemberships() async {
    try {
      final response = await dio.get('/memberships');

      // Handle API envelope: { success, message, data: { memberships: [...], total }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          final membershipsList = data['memberships'] as List;
          return membershipsList
              .map((e) => MembershipModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch memberships');
      }

      // If response is directly a list (fallback for different API formats)
      if (result is List) {
        return result
            .map((e) => MembershipModel.fromJson(e as Map<String, dynamic>))
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
  Future<MembershipModel> createMembership(MembershipModel membership) async {
    try {
      final response = await dio.post(
        '/membership',
        data: {
          'customerId': membership.customerId,
          'membershipType': membership.membershipType,
          'membershipLevel': membership.membershipLevel,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return MembershipModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the membership
        if (result.containsKey('id')) {
          return MembershipModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to create membership');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<void> deleteMembership(String id) async {
    try {
      final response = await dio.delete('/membership/$id');

      // Handle API envelope: { success, message, data: null, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] != true) {
          throw ServerFailure(result['message'] ?? 'Failed to delete membership');
        }
      }
      // If response is empty or success, return normally
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<MembershipStatusModel> checkMembershipStatus(String phoneNumber) async {
    try {
      final response = await dio.post(
        '/membership/check',
        data: {'phoneNumber': phoneNumber},
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return MembershipStatusModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        throw ServerFailure(result['message'] ?? 'Failed to check membership status');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<MembershipModel> updateMembership(String id, MembershipModel membership) async {
    try {
      final response = await dio.put(
        '/membership/$id',
        data: {
          'membershipType': membership.membershipType,
          'membershipLevel': membership.membershipLevel,
          'isActive': membership.isActive,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return MembershipModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the membership
        if (result.containsKey('id')) {
          return MembershipModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update membership');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }
}
