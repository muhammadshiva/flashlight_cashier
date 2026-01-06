import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/backup_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class UpdateBackupSettings implements UseCase<Unit, UpdateBackupSettingsParams> {
  final SettingsRepository repository;

  UpdateBackupSettings(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateBackupSettingsParams params) async {
    return await repository.updateBackupSettings(params.settings);
  }
}

class UpdateBackupSettingsParams extends Equatable {
  final BackupSettings settings;

  const UpdateBackupSettingsParams({required this.settings});

  @override
  List<Object> get props => [settings];
}
