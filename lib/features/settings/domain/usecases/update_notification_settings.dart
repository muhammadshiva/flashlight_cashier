import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class UpdateNotificationSettings implements UseCase<Unit, UpdateNotificationSettingsParams> {
  final SettingsRepository repository;

  UpdateNotificationSettings(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateNotificationSettingsParams params) async {
    return await repository.updateNotificationSettings(params.settings);
  }
}

class UpdateNotificationSettingsParams extends Equatable {
  final NotificationSettings settings;

  const UpdateNotificationSettingsParams({required this.settings});

  @override
  List<Object> get props => [settings];
}
