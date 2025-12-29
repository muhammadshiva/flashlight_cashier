import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/membership.dart';
import '../entities/membership_status.dart';
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

class CheckMembershipStatus implements UseCase<MembershipStatus, CheckMembershipStatusParams> {
  final MembershipRepository repository;
  CheckMembershipStatus(this.repository);
  @override
  Future<Either<Failure, MembershipStatus>> call(CheckMembershipStatusParams params) async {
    return await repository.checkMembershipStatus(params.phoneNumber);
  }
}

class CheckMembershipStatusParams extends Equatable {
  final String phoneNumber;

  const CheckMembershipStatusParams({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class UpdateMembership implements UseCase<Membership, UpdateMembershipParams> {
  final MembershipRepository repository;
  UpdateMembership(this.repository);
  @override
  Future<Either<Failure, Membership>> call(UpdateMembershipParams params) async {
    return await repository.updateMembership(params.id, params.membership);
  }
}

class UpdateMembershipParams extends Equatable {
  final String id;
  final Membership membership;

  const UpdateMembershipParams({required this.id, required this.membership});

  @override
  List<Object> get props => [id, membership];
}
