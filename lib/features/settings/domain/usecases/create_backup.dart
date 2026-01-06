import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class CreateBackup implements UseCase<String, CreateBackupParams> {
  final SettingsRepository repository;

  CreateBackup(this.repository);

  @override
  Future<Either<Failure, String>> call(CreateBackupParams params) async {
    return await repository.createBackup(params.backupPath);
  }
}

class CreateBackupParams extends Equatable {
  final String backupPath;

  const CreateBackupParams({required this.backupPath});

  @override
  List<Object> get props => [backupPath];
}
