import 'package:equatable/equatable.dart';
import 'report_data.dart';

class Report extends Equatable {
  final String reportId;
  final String reportType;
  final DateTime generatedAt;
  final ReportData data;

  const Report({
    required this.reportId,
    required this.reportType,
    required this.generatedAt,
    required this.data,
  });

  @override
  List<Object?> get props => [reportId, reportType, generatedAt, data];
}
