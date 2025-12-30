import 'package:equatable/equatable.dart';

/// Base class for all failures in the domain layer.
///
/// Failures represent error states that are returned from repositories
/// to use cases and BLoCs. They are converted from Exceptions thrown
/// in the data layer.
///
/// Flow: Exception (Data) -> Failure (Domain) -> Error Message (Presentation)
abstract class Failure extends Equatable {
  final String message;
  final int? errorCode;

  const Failure(this.message, [this.errorCode]);

  @override
  List<Object?> get props => [message, errorCode];
}

// ============================================
// Network Failures
// ============================================

/// Failure when there is no network connection.
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Tidak ada koneksi internet',
  ]) : super();
}

/// Failure when server returns an error.
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(
    super.message, [
    super.errorCode,
    this.statusCode,
  ]);

  @override
  List<Object?> get props => [message, errorCode, statusCode];
}

/// Failure when request times out.
class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'Koneksi timeout, silakan coba lagi',
  ]) : super();
}

// ============================================
// Authentication Failures
// ============================================

/// Failure when credentials are invalid.
class CredentialFailure extends Failure {
  const CredentialFailure([
    super.message = 'Email atau password salah',
  ]) : super();
}

/// Failure when session expires or token is invalid.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Sesi telah berakhir, silakan login kembali',
  ]) : super();
}

/// Failure when user lacks permissions.
class ForbiddenFailure extends Failure {
  const ForbiddenFailure([
    super.message = 'Anda tidak memiliki akses ke resource ini',
  ]) : super();
}

// ============================================
// Data Failures
// ============================================

/// Failure when requested data is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure([
    super.message = 'Data tidak ditemukan',
  ]) : super();
}

/// Failure when duplicate data exists.
class DuplicateFailure extends Failure {
  const DuplicateFailure([
    super.message = 'Data sudah ada',
  ]) : super();
}

/// Failure when data validation fails.
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure(
    super.message, [
    this.errors,
  ]) : super();

  @override
  List<Object?> get props => [message, errors];
}

// ============================================
// Cache Failures
// ============================================

/// Failure when cache operation fails.
class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'Gagal memuat data lokal',
  ]) : super();
}

/// Failure when no cached data is available.
class NoCachedDataFailure extends Failure {
  const NoCachedDataFailure([
    super.message = 'Data cache tidak tersedia',
  ]) : super();
}

// ============================================
// Input Validation Failures
// ============================================

/// Failure when email format is invalid.
class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure([
    super.message = 'Format email tidak valid',
  ]) : super();
}

/// Failure when password doesn't meet requirements.
class InvalidPasswordFailure extends Failure {
  const InvalidPasswordFailure([
    super.message = 'Password minimal 6 karakter',
  ]) : super();
}

/// Failure when input is empty.
class EmptyInputFailure extends Failure {
  const EmptyInputFailure([
    super.message = 'Input tidak boleh kosong',
  ]) : super();
}

// ============================================
// General Failures
// ============================================

/// Failure for unexpected errors.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    super.message = 'Terjadi kesalahan yang tidak terduga',
  ]) : super();
}

/// Failure when parsing data fails.
class ParseFailure extends Failure {
  const ParseFailure([
    super.message = 'Gagal memproses data',
  ]) : super();
}
