// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => _ReportModel(
      reportId: json['reportId'] as String,
      reportType: json['reportType'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      data: ReportDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportModelToJson(_ReportModel instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'reportType': instance.reportType,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'data': instance.data,
    };
