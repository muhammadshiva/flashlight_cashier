import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/membership_model.dart';
import '../models/membership_status_model.dart';

abstract class MembershipRemoteDataSource {
  Future<List<MembershipModel>> getMemberships();
  Future<MembershipModel> createMembership(MembershipModel membership);
  Future<void> deleteMembership(String id);
  Future<MembershipStatusModel> checkMembershipStatus(String phoneNumber);
  Future<MembershipModel> updateMembership(String id, MembershipModel membership);
}

class MembershipRemoteDataSourceImpl implements MembershipRemoteDataSource {
  final Dio dio;

  MembershipRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MembershipModel>> getMemberships() async {
    try {
      final response = await dio.get('/memberships');
      return (response.data as List)
          .map((e) => MembershipModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<MembershipModel> createMembership(MembershipModel membership) async {
    try {
      final response =
          await dio.post('/memberships', data: membership.toJson());
      return MembershipModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteMembership(String id) async {
    try {
      await dio.delete('/memberships/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<MembershipStatusModel> checkMembershipStatus(String phoneNumber) async {
    try {
      final response = await dio.post(
        '/api/membership/check',
        data: {'phoneNumber': phoneNumber},
      );

      // Response envelope: { success, message, data: {...}, error_code }
      final data = response.data['data'];
      return MembershipStatusModel.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<MembershipModel> updateMembership(String id, MembershipModel membership) async {
    try {
      final response = await dio.put(
        '/api/memberships/$id',
        data: membership.toJson(),
      );

      // Response envelope: { success, message, data: {...}, error_code }
      final data = response.data['data'];
      return MembershipModel.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
