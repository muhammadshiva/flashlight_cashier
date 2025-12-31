// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/member_vehicle.dart';

part 'member_vehicle_model.freezed.dart';
part 'member_vehicle_model.g.dart';

@freezed
abstract class MemberVehicleModel with _$MemberVehicleModel {
  const MemberVehicleModel._();

  const factory MemberVehicleModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "membershipId") String? membershipId,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "plateNumber") required String plateNumber,
    @JsonKey(name: "specs") String? specs,
    @JsonKey(name: "icon") String? icon,
  }) = _MemberVehicleModel;

  factory MemberVehicleModel.fromJson(Map<String, dynamic> json) =>
      _$MemberVehicleModelFromJson(json);

  /// Converts this model to a domain entity.
  MemberVehicle toEntity() => MemberVehicle(
        id: id,
        membershipId: membershipId,
        name: name,
        plateNumber: plateNumber,
        specs: specs,
        icon: icon,
      );

  /// Creates a model from a domain entity.
  factory MemberVehicleModel.fromEntity(MemberVehicle entity) {
    return MemberVehicleModel(
      id: entity.id,
      membershipId: entity.membershipId,
      name: entity.name,
      plateNumber: entity.plateNumber,
      specs: entity.specs,
      icon: entity.icon,
    );
  }
}
