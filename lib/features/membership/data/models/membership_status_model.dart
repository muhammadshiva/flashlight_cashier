// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/membership_status.dart';
import 'dart:convert';

part 'membership_status_model.freezed.dart';
part 'membership_status_model.g.dart';

MembershipStatusModel membershipStatusModelFromJson(String str) =>
    MembershipStatusModel.fromJson(json.decode(str));

String membershipStatusModelToJson(MembershipStatusModel data) =>
    json.encode(data.toJson());

@freezed
abstract class MembershipStatusModel with _$MembershipStatusModel {
  const MembershipStatusModel._();

  const factory MembershipStatusModel({
    @JsonKey(name: "type") required String type,
    @JsonKey(name: "message") required String message,
    @JsonKey(name: "membershipLevel") String? membershipLevel,
    @JsonKey(name: "isLoading") required bool isLoading,
  }) = _MembershipStatusModel;

  factory MembershipStatusModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipStatusModelFromJson(json);

  MembershipStatus toEntity() => MembershipStatus(
        type: type,
        message: message,
        membershipLevel: membershipLevel,
        isLoading: isLoading,
      );
}
