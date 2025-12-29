import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String username, String password);
  Future<AuthModel> refreshToken(String refreshToken);
  Future<User> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthModel> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerFailure(e.response?.data['message'] ?? 'Login Failed');
      } else {
        throw const ServerFailure('Connection Error');
      }
    }
  }

  @override
  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/api/refresh-token',
        data: {
          'refreshToken': refreshToken,
        },
      );

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerFailure(
            e.response?.data['message'] ?? 'Refresh Token Failed');
      } else {
        throw const ServerFailure('Connection Error');
      }
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final response = await dio.get('/api/profile');

      // Response envelope: { success, message, data: { user }, error_code }
      final userData = response.data['data'];
      return User.fromJson(userData);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerFailure(
            e.response?.data['message'] ?? 'Get Profile Failed');
      } else {
        throw const ServerFailure('Connection Error');
      }
    }
  }
}
