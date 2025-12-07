// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/membership.dart';
import 'dart:convert';

part 'membership_model.freezed.dart';
part 'membership_model.g.dart';

MembershipModel membershipModelFromJson(String str) =>
    MembershipModel.fromJson(json.decode(str));

String membershipModelToJson(MembershipModel data) =>
    json.encode(data.toJson());

@freezed
abstract class MembershipModel with _$MembershipModel {
  const MembershipModel._();

  const factory MembershipModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "customerId") required String customerId,
    @JsonKey(name: "membershipType") required String membershipType,
    @JsonKey(name: "membershipLevel") required String membershipLevel,
    @JsonKey(name: "isActive") required bool isActive,
  }) = _MembershipModel;

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  Membership toEntity() => Membership(
        id: id,
        customerId: customerId,
        membershipType: membershipType,
        membershipLevel: membershipLevel,
        isActive: isActive,
      );
}
