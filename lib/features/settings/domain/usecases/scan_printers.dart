import 'package:dartz/dartz.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class ScanPrinters implements UseCase<List<PrinterDevice>, NoParams> {
  final SettingsRepository repository;

  ScanPrinters(this.repository);

  @override
  Future<Either<Failure, List<PrinterDevice>>> call(NoParams params) async {
    return await repository.scanPrinters();
  }
}
