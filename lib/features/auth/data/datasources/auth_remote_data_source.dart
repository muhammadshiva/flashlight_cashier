import 'package:dio/dio.dart';

import '../../../../core/constants/api_constans.dart';
import '../../../../core/error/failures.dart';
import '../models/auth_model.dart';

/// Abstract interface for authentication remote data operations.
abstract class AuthRemoteDataSource {
  /// Logs in a user with [username] and [password].
  Future<AuthModel> login(String username, String password);

  /// Refreshes the authentication token using [refreshToken].
  Future<AuthModel> refreshToken(String refreshToken);

  /// Gets the current user's profile.
  Future<User> getProfile();
}

/// Implementation of [AuthRemoteDataSource] using Dio.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthModel> login(String username, String password) async {
    try {
      final response = await dio.post(
        ApiConst.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      // Response envelope: { success, message, data: { accessToken, refreshToken, user }, error_code }
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Login Failed',
      );
    }
  }

  @override
  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        ApiConst.refreshToken,
        data: {
          'refreshToken': refreshToken,
        },
      );

      // Response envelope: { success, message, data: { accessToken, refreshToken }, error_code }
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Refresh Token Failed',
      );
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final response = await dio.get(ApiConst.profile);

      // Response envelope: { success, message, data: { id, username, ... }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return User.fromJson(result['data'] as Map<String, dynamic>);
        }
        throw ServerFailure(result['message'] ?? 'Get Profile Failed');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Get Profile Failed',
      );
    }
  }
}
