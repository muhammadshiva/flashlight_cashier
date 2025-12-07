import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String token;
  final UserEntity user;

  const AuthEntity({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token, user];
}

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String username;
  final String role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, email, username, role];
}
