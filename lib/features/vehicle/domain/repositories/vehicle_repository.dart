import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vehicle.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<Vehicle>>> getVehicles();
  Future<Either<Failure, Vehicle>> createVehicle(Vehicle vehicle);
  Future<Either<Failure, void>> deleteVehicle(String id);
}
