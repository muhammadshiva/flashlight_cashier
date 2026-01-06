import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/notification_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class GetNotificationSettings implements UseCase<NotificationSettings, NoParams> {
  final SettingsRepository repository;

  GetNotificationSettings(this.repository);

  @override
  Future<Either<Failure, NotificationSettings>> call(NoParams params) async {
    return await repository.getNotificationSettings();
  }
}
