import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/member_vehicle.dart';
import '../../domain/repositories/member_vehicle_repository.dart';
import '../datasources/member_vehicle_remote_data_source.dart';
import '../models/member_vehicle_model.dart';

/// Implementation of [MemberVehicleRepository].
class MemberVehicleRepositoryImpl implements MemberVehicleRepository {
  final MemberVehicleRemoteDataSource remoteDataSource;

  MemberVehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MemberVehicle>>> getMemberVehicles() async {
    try {
      final models = await remoteDataSource.getMemberVehicles();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MemberVehicle>> createMemberVehicle(
      MemberVehicle vehicle) async {
    try {
      final model = MemberVehicleModel.fromEntity(vehicle);
      final result = await remoteDataSource.createMemberVehicle(model);
      return Right(result.toEntity());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MemberVehicle>> updateMemberVehicle(
      MemberVehicle vehicle) async {
    try {
      final model = MemberVehicleModel.fromEntity(vehicle);
      final result = await remoteDataSource.updateMemberVehicle(model);
      return Right(result.toEntity());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMemberVehicle(String id) async {
    try {
      await remoteDataSource.deleteMemberVehicle(id);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
