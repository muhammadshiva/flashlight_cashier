import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String username, String password);
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
}
