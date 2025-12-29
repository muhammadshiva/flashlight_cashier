import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/membership.dart';
import '../../domain/entities/membership_status.dart';
import '../../domain/repositories/membership_repository.dart';
import '../datasources/membership_remote_data_source.dart';
import '../models/membership_model.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipRemoteDataSource remoteDataSource;

  MembershipRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Membership>>> getMemberships() async {
    try {
      final result = await remoteDataSource.getMemberships();
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Membership>> createMembership(
      Membership membership) async {
    try {
      final model = MembershipModel(
        id: membership.id,
        customerId: membership.customerId,
        membershipType: membership.membershipType,
        membershipLevel: membership.membershipLevel,
        isActive: membership.isActive,
      );
      final result = await remoteDataSource.createMembership(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteMembership(String id) async {
    try {
      await remoteDataSource.deleteMembership(id);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, MembershipStatus>> checkMembershipStatus(
      String phoneNumber) async {
    try {
      final result = await remoteDataSource.checkMembershipStatus(phoneNumber);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Membership>> updateMembership(
      String id, Membership membership) async {
    try {
      final model = MembershipModel(
        id: membership.id,
        customerId: membership.customerId,
        membershipType: membership.membershipType,
        membershipLevel: membership.membershipLevel,
        isActive: membership.isActive,
      );
      final result = await remoteDataSource.updateMembership(id, model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
