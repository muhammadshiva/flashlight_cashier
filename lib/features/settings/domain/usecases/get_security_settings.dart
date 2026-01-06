import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class GetSecuritySettings implements UseCase<SecuritySettings, NoParams> {
  final SettingsRepository repository;

  GetSecuritySettings(this.repository);

  @override
  Future<Either<Failure, SecuritySettings>> call(NoParams params) async {
    return await repository.getSecuritySettings();
  }
}
