import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/report.dart';
import '../repositories/report_repository.dart';

class GenerateReport implements UseCase<Report, GenerateReportParams> {
  final ReportRepository repository;

  GenerateReport(this.repository);

  @override
  Future<Either<Failure, Report>> call(GenerateReportParams params) async {
    return await repository.generateReport(
      reportType: params.reportType,
      startDate: params.startDate,
      endDate: params.endDate,
      status: params.status,
      customerId: params.customerId,
    );
  }
}

class GenerateReportParams extends Equatable {
  final String reportType;
  final DateTime startDate;
  final DateTime endDate;
  final String? status;
  final String? customerId;

  const GenerateReportParams({
    required this.reportType,
    required this.startDate,
    required this.endDate,
    this.status,
    this.customerId,
  });

  @override
  List<Object?> get props => [reportType, startDate, endDate, status, customerId];
}
