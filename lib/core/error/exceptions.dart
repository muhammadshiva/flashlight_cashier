/// Base exception class for all application exceptions.
///
/// Exceptions are thrown from the Data layer (DataSources) and caught
/// in Repositories where they are converted to Failures.
///
/// Flow: DataSource throws Exception -> Repository catches and converts to Failure
abstract class AppException implements Exception {
  final String message;
  final int? errorCode;

  const AppException([this.message = 'An error occurred', this.errorCode]);

  @override
  String toString() => 'AppException: $message (code: $errorCode)';
}

// ============================================
// Network Exceptions
// ============================================

/// Thrown when there is no network connection.
class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Tidak ada koneksi internet',
  ]) : super();
}

/// Thrown when the server returns an error response.
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    String message = 'Terjadi kesalahan pada server',
    int? errorCode,
    this.statusCode,
  }) : super(message, errorCode);

  @override
  String toString() =>
      'ServerException: $message (statusCode: $statusCode, errorCode: $errorCode)';
}

/// Thrown when request times out.
class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'Koneksi timeout, silakan coba lagi',
  ]) : super();
}

// ============================================
// Authentication Exceptions
// ============================================

/// Thrown when authentication fails (wrong credentials).
class AuthException extends AppException {
  const AuthException([
    super.message = 'Email atau password salah',
  ]) : super();
}

/// Thrown when token is invalid or expired.
class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Sesi telah berakhir, silakan login kembali',
  ]) : super();
}

/// Thrown when user doesn't have permission to access resource.
class ForbiddenException extends AppException {
  const ForbiddenException([
    super.message = 'Anda tidak memiliki akses ke resource ini',
  ]) : super();
}

// ============================================
// Data Exceptions
// ============================================

/// Thrown when requested data is not found.
class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'Data tidak ditemukan',
  ]) : super();
}

/// Thrown when trying to create duplicate data.
class DuplicateException extends AppException {
  const DuplicateException([
    super.message = 'Data sudah ada',
  ]) : super();
}

/// Thrown when data validation fails on server side.
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    String message = 'Data tidak valid',
    this.errors,
  }) : super(message);

  @override
  String toString() => 'ValidationException: $message, errors: $errors';
}

// ============================================
// Cache Exceptions
// ============================================

/// Thrown when cache operation fails.
class CacheException extends AppException {
  const CacheException([
    super.message = 'Gagal memuat data lokal',
  ]) : super();
}

/// Thrown when cached data is not available.
class NoCachedDataException extends AppException {
  const NoCachedDataException([
    super.message = 'Data cache tidak tersedia',
  ]) : super();
}

// ============================================
// Input Validation Exceptions
// ============================================

/// Thrown when email format is invalid.
class InvalidEmailException extends AppException {
  const InvalidEmailException([
    super.message = 'Format email tidak valid',
  ]) : super();
}

/// Thrown when password doesn't meet requirements.
class InvalidPasswordException extends AppException {
  const InvalidPasswordException([
    super.message = 'Password minimal 6 karakter',
  ]) : super();
}

/// Thrown when input data is empty or null.
class EmptyInputException extends AppException {
  const EmptyInputException([
    super.message = 'Input tidak boleh kosong',
  ]) : super();
}

// ============================================
// General Exceptions
// ============================================

/// Thrown for unexpected errors.
class UnexpectedException extends AppException {
  const UnexpectedException([
    super.message = 'Terjadi kesalahan yang tidak terduga',
  ]) : super();
}

/// Thrown when parsing data fails.
class ParseException extends AppException {
  const ParseException([
    super.message = 'Gagal memproses data',
  ]) : super();
}
