import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/features/vehicle/domain/usecases/vehicle_usecases.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/vehicle_remote_data_source.dart';
import '../models/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Vehicle>>> getVehicles({required GetVehicleParams params}) async {
    try {
      final result = await remoteDataSource.getVehicles(params: params);
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Vehicle>> createVehicle(Vehicle vehicle) async {
    try {
      final model = VehicleModel(
        id: vehicle.id,
        licensePlate: vehicle.licensePlate,
        vehicleBrand: vehicle.vehicleBrand,
        vehicleColor: vehicle.vehicleColor,
        vehicleCategory: vehicle.vehicleCategory,
        vehicleSpecs: vehicle.vehicleSpecs,
      );
      final result = await remoteDataSource.createVehicle(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Vehicle>> updateVehicle(Vehicle vehicle) async {
    try {
      final model = VehicleModel(
        id: vehicle.id,
        licensePlate: vehicle.licensePlate,
        vehicleBrand: vehicle.vehicleBrand,
        vehicleColor: vehicle.vehicleColor,
        vehicleCategory: vehicle.vehicleCategory,
        vehicleSpecs: vehicle.vehicleSpecs,
      );
      final result = await remoteDataSource.updateVehicle(model);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(String id) async {
    try {
      await remoteDataSource.deleteVehicle(id);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
