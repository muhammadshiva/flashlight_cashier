import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class UpdatePrinterSettings implements UseCase<Unit, UpdatePrinterSettingsParams> {
  final SettingsRepository repository;

  UpdatePrinterSettings(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdatePrinterSettingsParams params) async {
    return await repository.updatePrinterSettings(params.settings);
  }
}

class UpdatePrinterSettingsParams extends Equatable {
  final PrinterSettings settings;

  const UpdatePrinterSettingsParams({required this.settings});

  @override
  List<Object> get props => [settings];
}
