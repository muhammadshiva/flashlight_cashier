import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../cache/secure_local_storage.dart';
import '../constants/app_constants.dart';

/// HTTP client wrapper using Dio with automatic Bearer token injection.
///
/// Uses [SecureLocalStorage] for secure token retrieval instead of
/// SharedPreferences for better security.
class DioClient {
  final Dio _dio;
  final SecureLocalStorage _secureStorage;
  final Talker _talker;

  DioClient(this._secureStorage, this._talker) : _dio = Dio() {
    String baseUrl = 'http://matadevserver.tail96da83.ts.net/api';

    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..responseType = ResponseType.json;

    _dio.interceptors.add(
      TalkerDioLogger(
        talker: _talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
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
