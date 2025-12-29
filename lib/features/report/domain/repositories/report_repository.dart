import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/report.dart';

abstract class ReportRepository {
  Future<Either<Failure, Report>> generateReport({
    required String reportType,
    required DateTime startDate,
    required DateTime endDate,
    String? status,
    String? customerId,
  });
}
