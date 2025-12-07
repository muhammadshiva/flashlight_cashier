import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/membership.dart';

abstract class MembershipRepository {
  Future<Either<Failure, List<Membership>>> getMemberships();
  Future<Either<Failure, Membership>> createMembership(Membership membership);
  Future<Either<Failure, void>> deleteMembership(String id);
}
