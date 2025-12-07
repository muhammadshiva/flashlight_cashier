import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/membership.dart';
import '../repositories/membership_repository.dart';

class GetMemberships implements UseCase<List<Membership>, NoParams> {
  final MembershipRepository repository;
  GetMemberships(this.repository);
  @override
  Future<Either<Failure, List<Membership>>> call(NoParams params) async {
    return await repository.getMemberships();
  }
}

class CreateMembership implements UseCase<Membership, Membership> {
  final MembershipRepository repository;
  CreateMembership(this.repository);
  @override
  Future<Either<Failure, Membership>> call(Membership params) async {
    return await repository.createMembership(params);
  }
}

class DeleteMembership implements UseCase<void, String> {
  final MembershipRepository repository;
  DeleteMembership(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteMembership(params);
  }
}
