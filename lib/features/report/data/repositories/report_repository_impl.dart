import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_remote_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource remoteDataSource;

  ReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Report>> generateReport({
    required String reportType,
    required DateTime startDate,
    required DateTime endDate,
    String? status,
    String? customerId,
  }) async {
    try {
      final result = await remoteDataSource.generateReport(
        reportType: reportType,
        startDate: startDate,
        endDate: endDate,
        status: status,
        customerId: customerId,
      );
      return Right(result.toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
