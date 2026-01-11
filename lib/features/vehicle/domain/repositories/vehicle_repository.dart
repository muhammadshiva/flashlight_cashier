import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/features/vehicle/domain/usecases/vehicle_usecases.dart';

import '../../../../core/error/failures.dart';
import '../entities/vehicle.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<Vehicle>>> getVehicles({required GetVehicleParams params});
  Future<Either<Failure, Vehicle>> createVehicle(Vehicle vehicle);
  Future<Either<Failure, Vehicle>> updateVehicle(Vehicle vehicle);
  Future<Either<Failure, void>> deleteVehicle(String id);
}
