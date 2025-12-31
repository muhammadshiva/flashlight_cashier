import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsers implements UseCase<List<User>, NoParams> {
  final UserRepository repository;
  GetUsers(this.repository);
  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getUsers();
  }
}

class CreateUser implements UseCase<User, CreateUserParams> {
  final UserRepository repository;
  CreateUser(this.repository);
  @override
  Future<Either<Failure, User>> call(CreateUserParams params) async {
    return await repository.createUser(params.user, params.password);
  }
}

class CreateUserParams {
  final User user;
  final String password;
  CreateUserParams({required this.user, required this.password});
}

class UpdateUser implements UseCase<User, User> {
  final UserRepository repository;
  UpdateUser(this.repository);
  @override
  Future<Either<Failure, User>> call(User params) async {
    return await repository.updateUser(params);
  }
}

class DeleteUser implements UseCase<void, String> {
  final UserRepository repository;
  DeleteUser(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteUser(params);
  }
}

class ResetPassword implements UseCase<void, ResetPasswordParams> {
  final UserRepository repository;
  ResetPassword(this.repository);
  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(params.id, params.newPassword);
  }
}

class ResetPasswordParams {
  final String id;
  final String newPassword;
  ResetPasswordParams({required this.id, required this.newPassword});
}
