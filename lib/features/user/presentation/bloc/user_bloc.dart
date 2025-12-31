import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/user_usecases.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final CreateUser createUser;
  final UpdateUser updateUser;
  final DeleteUser deleteUser;
  final ResetPassword resetPassword;

  UserBloc({
    required this.getUsers,
    required this.createUser,
    required this.updateUser,
    required this.deleteUser,
    required this.resetPassword,
  }) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      final result = await getUsers(NoParams());
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (users) => emit(UserLoaded(users)),
      );
    });

    on<CreateUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await createUser(
          CreateUserParams(user: event.user, password: event.password));
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (user) {
          emit(const UserOperationSuccess("User created successfully"));
          add(LoadUsers());
        },
      );
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await updateUser(event.user);
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (user) {
          emit(const UserOperationSuccess("User updated successfully"));
          add(LoadUsers());
        },
      );
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await deleteUser(event.id);
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (success) {
          emit(const UserOperationSuccess("User deleted successfully"));
          add(LoadUsers());
        },
      );
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(UserLoading());
      final result = await resetPassword(
        ResetPasswordParams(id: event.id, newPassword: event.newPassword),
      );
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (success) {
          emit(const UserOperationSuccess("Password reset successfully"));
          add(LoadUsers());
        },
      );
    });
  }
}
