// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/report.dart';
import 'report_data_model.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
abstract class ReportModel with _$ReportModel {
  const ReportModel._();

  const factory ReportModel({
    @JsonKey(name: 'reportId') required String reportId,
    @JsonKey(name: 'reportType') required String reportType,
    @JsonKey(name: 'generatedAt') required DateTime generatedAt,
    @JsonKey(name: 'data') required ReportDataModel data,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Report toEntity() => Report(
        reportId: reportId,
        reportType: reportType,
        generatedAt: generatedAt,
        data: data.toEntity(),
      );
}
