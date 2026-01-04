import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_settings.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class GetPrinterSettings implements UseCase<PrinterSettings, NoParams> {
  final SettingsRepository repository;

  GetPrinterSettings(this.repository);

  @override
  Future<Either<Failure, PrinterSettings>> call(NoParams params) async {
    return await repository.getPrinterSettings();
  }
}
