import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/vehicle.dart';
import '../repositories/vehicle_repository.dart';

class GetVehicles implements UseCase<List<Vehicle>, NoParams> {
  final VehicleRepository repository;
  GetVehicles(this.repository);
  @override
  Future<Either<Failure, List<Vehicle>>> call(NoParams params) async {
    return await repository.getVehicles();
  }
}

class CreateVehicle implements UseCase<Vehicle, Vehicle> {
  final VehicleRepository repository;
  CreateVehicle(this.repository);
  @override
  Future<Either<Failure, Vehicle>> call(Vehicle params) async {
    return await repository.createVehicle(params);
  }
}

class UpdateVehicle implements UseCase<Vehicle, Vehicle> {
  final VehicleRepository repository;
  UpdateVehicle(this.repository);
  @override
  Future<Either<Failure, Vehicle>> call(Vehicle params) async {
    return await repository.updateVehicle(params);
  }
}

class DeleteVehicle implements UseCase<void, String> {
  final VehicleRepository repository;
  DeleteVehicle(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteVehicle(params);
  }
}
