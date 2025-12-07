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
    @JsonKey(name: "licensePlate") required String licensePlate,
    @JsonKey(name: "vehicleBrand") required String vehicleBrand,
    @JsonKey(name: "vehicleColor") required String vehicleColor,
    @JsonKey(name: "vehicleCategory") required String vehicleCategory,
    @JsonKey(name: "vehicleSpecs") required String vehicleSpecs,
  }) = _VehicleModel;

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Vehicle toEntity() => Vehicle(
        id: id,
        licensePlate: licensePlate,
        vehicleBrand: vehicleBrand,
        vehicleColor: vehicleColor,
        vehicleCategory: vehicleCategory,
        vehicleSpecs: vehicleSpecs,
      );
}
