import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/member_vehicle.dart';
import '../repositories/member_vehicle_repository.dart';

/// Use case to get all member vehicles.
class GetMemberVehicles implements UseCase<List<MemberVehicle>, NoParams> {
  final MemberVehicleRepository repository;

  GetMemberVehicles(this.repository);

  @override
  Future<Either<Failure, List<MemberVehicle>>> call(NoParams params) async {
    return await repository.getMemberVehicles();
  }
}

/// Use case to create a new member vehicle.
class CreateMemberVehicle implements UseCase<MemberVehicle, MemberVehicle> {
  final MemberVehicleRepository repository;

  CreateMemberVehicle(this.repository);

  @override
  Future<Either<Failure, MemberVehicle>> call(MemberVehicle params) async {
    return await repository.createMemberVehicle(params);
  }
}

/// Use case to update an existing member vehicle.
class UpdateMemberVehicle implements UseCase<MemberVehicle, MemberVehicle> {
  final MemberVehicleRepository repository;

  UpdateMemberVehicle(this.repository);

  @override
  Future<Either<Failure, MemberVehicle>> call(MemberVehicle params) async {
    return await repository.updateMemberVehicle(params);
  }
}

/// Use case to delete a member vehicle by ID.
class DeleteMemberVehicle implements UseCase<void, String> {
  final MemberVehicleRepository repository;

  DeleteMemberVehicle(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteMemberVehicle(params);
  }
}
