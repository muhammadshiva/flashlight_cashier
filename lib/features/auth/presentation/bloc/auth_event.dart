part of 'auth_bloc.dart';

/// Base class for all authentication events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event to request login with username and password.
class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

/// Event to request logout.
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

/// Event to check current authentication status.
///
/// Used on app startup to determine if user is already authenticated.
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}
