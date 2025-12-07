import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String id;
  final String licensePlate;
  final String vehicleBrand;
  final String vehicleColor;
  final String vehicleCategory;
  final String vehicleSpecs;

  const Vehicle({
    required this.id,
    required this.licensePlate,
    required this.vehicleBrand,
    required this.vehicleColor,
    required this.vehicleCategory,
    required this.vehicleSpecs,
  });

  @override
  List<Object?> get props => [
        id,
        licensePlate,
        vehicleBrand,
        vehicleColor,
        vehicleCategory,
        vehicleSpecs
      ];
}
