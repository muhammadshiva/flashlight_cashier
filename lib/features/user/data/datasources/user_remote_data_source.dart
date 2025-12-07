import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> createUser(User user, String password);
  Future<UserModel> updateUser(User user);
  Future<void> deleteUser(String id);
  Future<void> resetPassword(String id, String newPassword);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      // Assuming standard wrapper for list
      final response = await dio.get('/users');
      // If response.data is { success: true, data: { users: [...] } }
      final data = response.data;
      if (data['success'] == true && data['data'] != null) {
        final usersList = data['data']['users'] as List;
        return usersList.map((e) => UserModel.fromJson(e)).toList();
      }
      throw ServerFailure(data['message'] ?? 'Failed to fetch users');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<UserModel> createUser(User user, String password) async {
    try {
      final body = {
        'username': user.username,
        'fullName': user.fullName,
        'email': user.email,
        'role': user.role,
        'password': password,
      };
      final response = await dio.post('/users', data: body);
      // Assuming response.data is { success: true, data: {...} } or just data
      final data = response.data;
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        return UserModel.fromJson(data['data']);
      }
      return UserModel.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<UserModel> updateUser(User user) async {
    try {
      final body = {
        'username': user.username,
        'fullName': user.fullName,
        'email': user.email,
        'role': user.role,
        'status': user.status,
      };
      final response = await dio.put('/users/${user.id}', data: body);
      final data = response.data;
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        return UserModel.fromJson(data['data']);
      }
      return UserModel.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await dio.delete('/users/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> resetPassword(String id, String newPassword) async {
    try {
      await dio
          .put('/users/$id/reset-password', data: {'newPassword': newPassword});
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
