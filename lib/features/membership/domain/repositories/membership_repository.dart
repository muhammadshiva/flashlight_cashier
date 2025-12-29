import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/membership.dart';
import '../entities/membership_status.dart';

abstract class MembershipRepository {
  Future<Either<Failure, List<Membership>>> getMemberships();
  Future<Either<Failure, Membership>> createMembership(Membership membership);
  Future<Either<Failure, void>> deleteMembership(String id);
  Future<Either<Failure, MembershipStatus>> checkMembershipStatus(String phoneNumber);
  Future<Either<Failure, Membership>> updateMembership(String id, Membership membership);
}
