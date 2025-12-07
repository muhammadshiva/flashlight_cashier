import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;
  final String password;
  const CreateUserEvent(this.user, this.password);
  @override
  List<Object?> get props => [user, password];
}

class UpdateUserEvent extends UserEvent {
  final User user;
  const UpdateUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class DeleteUserEvent extends UserEvent {
  final String id;
  const DeleteUserEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class ResetPasswordEvent extends UserEvent {
  final String id;
  final String newPassword;
  const ResetPasswordEvent(this.id, this.newPassword);
  @override
  List<Object?> get props => [id, newPassword];
}
