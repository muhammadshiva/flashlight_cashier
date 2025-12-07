import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  DioClient(this._sharedPreferences) : _dio = Dio() {
    String baseUrl = 'https://369820dfc74d.ngrok-free.app/api';

    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _sharedPreferences.getString('auth_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Handle global errors like 401 Unauthorized here if needed
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
