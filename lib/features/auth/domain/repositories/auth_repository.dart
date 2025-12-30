import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';

/// Abstract repository interface for authentication operations.
///
/// This interface is implemented by [AuthRepositoryImpl] in the data layer.
abstract class AuthRepository {
  /// Authenticates a user with username and password.
  ///
  /// Returns [AuthEntity] on success, [Failure] on error.
  Future<Either<Failure, AuthEntity>> login(String username, String password);

  /// Refreshes the authentication token.
  ///
  /// Returns new [AuthEntity] with updated tokens on success.
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken);

  /// Gets the current user's profile.
  ///
  /// Returns [UserEntity] on success, [Failure] on error.
  Future<Either<Failure, UserEntity>> getProfile();

  /// Logs out the current user.
  ///
  /// Clears cached tokens and session data.
  Future<Either<Failure, void>> logout();
}
