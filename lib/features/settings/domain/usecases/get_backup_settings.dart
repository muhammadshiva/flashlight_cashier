import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/backup_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class GetBackupSettings implements UseCase<BackupSettings, NoParams> {
  final SettingsRepository repository;

  GetBackupSettings(this.repository);

  @override
  Future<Either<Failure, BackupSettings>> call(NoParams params) async {
    return await repository.getBackupSettings();
  }
}
