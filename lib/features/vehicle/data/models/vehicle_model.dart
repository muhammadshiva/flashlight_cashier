// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/vehicle.dart';
import 'dart:convert';

part 'vehicle_model.freezed.dart';
part 'vehicle_model.g.dart';

VehicleModel vehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

@freezed
abstract class VehicleModel with _$VehicleModel {
  const VehicleModel._();

  const factory VehicleModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "customerId") String? customerId,
    @JsonKey(name: "licensePlate") required String licensePlate,
    @JsonKey(name: "model") String? model,
    @JsonKey(name: "vehicleBrand") String? vehicleBrand,
    @JsonKey(name: "vehicleColor") String? vehicleColor,
    @JsonKey(name: "category") String? category,
    @JsonKey(name: "vehicleCategory") String? vehicleCategory,
    @JsonKey(name: "vehicleSpecs") String? vehicleSpecs,
  }) = _VehicleModel;

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Vehicle toEntity() => Vehicle(
        id: id,
        customerId: customerId,
        licensePlate: licensePlate,
        vehicleBrand: vehicleBrand ?? model ?? '',
        vehicleColor: vehicleColor ?? '',
        vehicleCategory: vehicleCategory ?? category ?? '',
        vehicleSpecs: vehicleSpecs ?? '',
      );
}
