part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String username;
  final String fullName;
  final String email;
  final String password;

  const SignUpRequested({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, fullName, email, password];
}
