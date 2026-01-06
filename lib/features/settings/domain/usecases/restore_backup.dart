import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class RestoreBackup implements UseCase<Unit, RestoreBackupParams> {
  final SettingsRepository repository;

  RestoreBackup(this.repository);

  @override
  Future<Either<Failure, Unit>> call(RestoreBackupParams params) async {
    return await repository.restoreBackup(params.backupPath);
  }
}

class RestoreBackupParams extends Equatable {
  final String backupPath;

  const RestoreBackupParams({required this.backupPath});

  @override
  List<Object> get props => [backupPath];
}
