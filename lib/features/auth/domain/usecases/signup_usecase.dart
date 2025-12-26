import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<AuthEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(SignUpParams params) async {
    return await repository.signUp(
      params.username,
      params.fullName,
      params.email,
      params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String username;
  final String fullName;
  final String email;
  final String password;

  const SignUpParams({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, fullName, email, password];
}
