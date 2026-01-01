import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/app_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class UpdateAppSettings implements UseCase<Unit, UpdateAppSettingsParams> {
  final SettingsRepository repository;

  UpdateAppSettings(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateAppSettingsParams params) async {
    return await repository.updateAppSettings(params.settings);
  }
}

class UpdateAppSettingsParams extends Equatable {
  final AppSettings settings;

  const UpdateAppSettingsParams({required this.settings});

  @override
  List<Object> get props => [settings];
}
