import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/member_vehicle.dart';

/// Abstract repository interface for member vehicle operations.
abstract class MemberVehicleRepository {
  /// Gets all member vehicles.
  Future<Either<Failure, List<MemberVehicle>>> getMemberVehicles();

  /// Creates a new member vehicle.
  Future<Either<Failure, MemberVehicle>> createMemberVehicle(
      MemberVehicle vehicle);

  /// Updates an existing member vehicle.
  Future<Either<Failure, MemberVehicle>> updateMemberVehicle(
      MemberVehicle vehicle);

  /// Deletes a member vehicle by ID.
  Future<Either<Failure, void>> deleteMemberVehicle(String id);
}
