import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class DisconnectPrinter implements UseCase<Unit, NoParams> {
  final SettingsRepository repository;

  DisconnectPrinter(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.disconnectPrinter();
  }
}
