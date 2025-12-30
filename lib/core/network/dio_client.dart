import 'package:dio/dio.dart';

import '../cache/secure_local_storage.dart';
import '../constants/app_constants.dart';

/// HTTP client wrapper using Dio with automatic Bearer token injection.
///
/// Uses [SecureLocalStorage] for secure token retrieval instead of
/// SharedPreferences for better security.
class DioClient {
  final Dio _dio;
  final SecureLocalStorage _secureStorage;

  DioClient(this._secureStorage) : _dio = Dio() {
    String baseUrl = 'https://369820dfc74d.ngrok-free.app/api';

    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  /// Handles request interception to add Bearer token.
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _secureStorage.read(AppConstants.authTokenKey);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    } catch (e) {
      // If there's an error reading the token, proceed without it
      handler.next(options);
    }
  }

  /// Handles error interception.
  void _onError(DioException e, ErrorInterceptorHandler handler) {
    // Handle global errors like 401 Unauthorized here if needed
    handler.next(e);
  }

  Dio get dio => _dio;
}
