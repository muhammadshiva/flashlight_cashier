import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/security_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class UpdateSecuritySettings implements UseCase<Unit, UpdateSecuritySettingsParams> {
  final SettingsRepository repository;

  UpdateSecuritySettings(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateSecuritySettingsParams params) async {
    return await repository.updateSecuritySettings(params.settings);
  }
}

class UpdateSecuritySettingsParams extends Equatable {
  final SecuritySettings settings;

  const UpdateSecuritySettingsParams({required this.settings});

  @override
  List<Object> get props => [settings];
}
