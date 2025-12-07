import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String role;
  final String status;

  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.role,
    required this.status,
  });

  @override
  List<Object?> get props => [id, username, fullName, email, role, status];
}
