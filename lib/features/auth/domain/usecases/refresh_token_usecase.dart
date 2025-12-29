import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase implements UseCase<AuthEntity, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(RefreshTokenParams params) async {
    return await repository.refreshToken(params.refreshToken);
  }
}

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});

  @override
  List<Object> get props => [refreshToken];
}
