import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flashlight_pos/core/error/failures.dart';
import 'package:flashlight_pos/core/usecase/usecase.dart';
import 'package:flashlight_pos/features/settings/domain/entities/printer_device.dart';
import 'package:flashlight_pos/features/settings/domain/repositories/settings_repository.dart';

class ConnectPrinter implements UseCase<bool, ConnectPrinterParams> {
  final SettingsRepository repository;

  ConnectPrinter(this.repository);

  @override
  Future<Either<Failure, bool>> call(ConnectPrinterParams params) async {
    return await repository.connectPrinter(params.device);
  }
}

class ConnectPrinterParams extends Equatable {
  final PrinterDevice device;

  const ConnectPrinterParams({required this.device});

  @override
  List<Object> get props => [device];
}
