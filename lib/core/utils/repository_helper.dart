import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import '../network/network_info.dart';
import 'failure_mapper.dart';

/// Helper class for repository implementations.
///
/// Provides utility methods for common repository patterns like:
/// - Safe API calls with proper error handling
/// - Network connectivity checks
/// - Exception to Failure mapping
class RepositoryHelper {
  /// Executes an API call with comprehensive error handling.
  ///
  /// Catches all exceptions and converts them to appropriate [Failure] types.
  /// Use this for simple API calls that don't need network checking.
  static Future<Either<Failure, T>> safeApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on AppException catch (e) {
      return Left(FailureMapper.mapExceptionToFailure(e));
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  /// Executes an API call with network connectivity check.
  ///
  /// First checks if the device is connected to the internet.
  /// If not connected, returns a [NetworkFailure] immediately.
  /// Otherwise, proceeds with the API call.
  static Future<Either<Failure, T>> safeApiCallWithNetworkCheck<T>(
    NetworkInfo networkInfo,
    Future<T> Function() apiCall,
  ) async {
    // Check network connectivity first
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    return safeApiCall(apiCall);
  }

  /// Executes an API call with offline fallback support.
  ///
  /// If online, fetches from remote and optionally caches the result.
  /// If offline, attempts to load from cache.
  static Future<Either<Failure, T>> safeApiCallWithCache<T>({
    required NetworkInfo networkInfo,
    required Future<T> Function() remoteCall,
    required Future<T> Function() cacheCall,
    Future<void> Function(T data)? cacheData,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteCall();

        // Cache the result if caching function is provided
        if (cacheData != null) {
          try {
            await cacheData(result);
          } catch (_) {
            // Silently fail cache operation, don't break the main flow
          }
        }

        return Right(result);
      } on AppException catch (e) {
        return Left(FailureMapper.mapExceptionToFailure(e));
      } on DioException catch (e) {
        return Left(_handleDioException(e));
      } on Failure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(UnexpectedFailure(e.toString()));
      }
    } else {
      // Offline: try to load from cache
      try {
        final cachedData = await cacheCall();
        return Right(cachedData);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on NoCachedDataException catch (e) {
        return Left(NoCachedDataFailure(e.message));
      } catch (e) {
        return Left(const NetworkFailure(
          'Tidak ada koneksi internet dan data cache tidak tersedia',
        ));
      }
    }
  }

  /// Handles DioException and converts to appropriate Failure.
  static Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();

      case DioExceptionType.connectionError:
        return const NetworkFailure();

      case DioExceptionType.badResponse:
        return _handleBadResponse(e.response);

      case DioExceptionType.cancel:
        return const ServerFailure('Request dibatalkan');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Sertifikat SSL tidak valid');

      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return const NetworkFailure();
        }
        return ServerFailure(e.message ?? 'Terjadi kesalahan tidak dikenal');
    }
  }

  /// Handles HTTP error responses.
  static Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return const ServerFailure('Tidak ada response dari server');
    }

    final statusCode = response.statusCode ?? 0;
    final data = response.data;
    String message = 'Terjadi kesalahan pada server';
    int? errorCode;

    // Try to extract message and error_code from API envelope
    if (data is Map<String, dynamic>) {
      message = data['message'] as String? ?? message;
      errorCode = data['error_code'] as int?;
    }

    switch (statusCode) {
      case 400:
        // Check if it's a validation error
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          return ValidationFailure(
            message,
            _parseValidationErrors(data['errors']),
          );
        }
        return ServerFailure(message, errorCode, statusCode);

      case 401:
        return UnauthorizedFailure(message);

      case 403:
        return ForbiddenFailure(message);

      case 404:
        return NotFoundFailure(message);

      case 409:
        return DuplicateFailure(message);

      case 422:
        // Unprocessable Entity - usually validation errors
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          return ValidationFailure(
            message,
            _parseValidationErrors(data['errors']),
          );
        }
        return ValidationFailure(message);

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          'Server sedang mengalami gangguan',
          errorCode,
          statusCode,
        );

      default:
        return ServerFailure(message, errorCode, statusCode);
    }
  }

  /// Parses validation errors from API response.
  static Map<String, List<String>>? _parseValidationErrors(dynamic errors) {
    if (errors == null) return null;

    if (errors is Map<String, dynamic>) {
      return errors.map((key, value) {
        if (value is List) {
          return MapEntry(key, value.map((e) => e.toString()).toList());
        } else {
          return MapEntry(key, [value.toString()]);
        }
      });
    }

    return null;
  }
}
