import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/vehicle.dart';

VehicleModel vehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel extends Equatable {
  final String id;
  final String? customerId;
  final String licensePlate;
  final String? model;
  final String? vehicleBrand;
  final String? vehicleColor;
  final String? category;
  final String? vehicleCategory;
  final String? vehicleSpecs;

  const VehicleModel({
    required this.id,
    this.customerId,
    required this.licensePlate,
    this.model,
    this.vehicleBrand,
    this.vehicleColor,
    this.category,
    this.vehicleCategory,
    this.vehicleSpecs,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json["id"] as String,
        customerId: json["customerId"] as String?,
        licensePlate: json["licensePlate"] as String,
        model: json["model"] as String?,
        vehicleBrand: json["vehicleBrand"] as String?,
        vehicleColor: json["vehicleColor"] as String?,
        category: json["category"] as String?,
        vehicleCategory: json["vehicleCategory"] as String?,
        vehicleSpecs: json["vehicleSpecs"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        if (customerId != null) "customerId": customerId,
        "licensePlate": licensePlate,
        if (model != null) "model": model,
        if (vehicleBrand != null) "vehicleBrand": vehicleBrand,
        if (vehicleColor != null) "vehicleColor": vehicleColor,
        if (category != null) "category": category,
        if (vehicleCategory != null) "vehicleCategory": vehicleCategory,
        if (vehicleSpecs != null) "vehicleSpecs": vehicleSpecs,
      };

  VehicleModel copyWith({
    String? id,
    String? customerId,
    String? licensePlate,
    String? model,
    String? vehicleBrand,
    String? vehicleColor,
    String? category,
    String? vehicleCategory,
    String? vehicleSpecs,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      licensePlate: licensePlate ?? this.licensePlate,
      model: model ?? this.model,
      vehicleBrand: vehicleBrand ?? this.vehicleBrand,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      category: category ?? this.category,
      vehicleCategory: vehicleCategory ?? this.vehicleCategory,
      vehicleSpecs: vehicleSpecs ?? this.vehicleSpecs,
    );
  }

  Vehicle toEntity() => Vehicle(
        id: id,
        customerId: customerId,
        licensePlate: licensePlate,
        vehicleBrand: vehicleBrand ?? model ?? '',
        vehicleColor: vehicleColor ?? '',
        vehicleCategory: vehicleCategory ?? category ?? '',
        vehicleSpecs: vehicleSpecs ?? '',
      );

  @override
  List<Object?> get props => [
        id,
        customerId,
        licensePlate,
        model,
        vehicleBrand,
        vehicleColor,
        category,
        vehicleCategory,
        vehicleSpecs,
      ];

  /// Static getter for prototype dummy data
  static List<VehicleModel> get getPrototypeDataVehicles {
    return [
      // Vehicle 1 - Honda Beat
      const VehicleModel(
        id: 'veh-001',
        customerId: 'cust-001',
        licensePlate: 'B 1234 XYZ',
        model: 'Beat',
        vehicleBrand: 'Honda',
        vehicleColor: 'Merah',
        category: 'Motor',
        vehicleCategory: 'Motor',
        vehicleSpecs: '110cc, Matic',
      ),

      // Vehicle 2 - Yamaha NMAX
      const VehicleModel(
        id: 'veh-002',
        customerId: 'cust-002',
        licensePlate: 'B 5678 ABC',
        model: 'NMAX',
        vehicleBrand: 'Yamaha',
        vehicleColor: 'Hitam',
        category: 'Motor',
        vehicleCategory: 'Motor',
        vehicleSpecs: '155cc, Matic',
      ),

      // Vehicle 3 - Toyota Avanza
      const VehicleModel(
        id: 'veh-003',
        customerId: 'cust-003',
        licensePlate: 'B 9012 DEF',
        model: 'Avanza',
        vehicleBrand: 'Toyota',
        vehicleColor: 'Putih',
        category: 'Mobil',
        vehicleCategory: 'Mobil',
        vehicleSpecs: '1.3L, Manual, 7 Seater',
      ),

      // Vehicle 4 - Honda PCX
      const VehicleModel(
        id: 'veh-004',
        customerId: 'cust-004',
        licensePlate: 'B 3456 GHI',
        model: 'PCX',
        vehicleBrand: 'Honda',
        vehicleColor: 'Abu-abu',
        category: 'Motor',
        vehicleCategory: 'Motor',
        vehicleSpecs: '160cc, Matic',
      ),

      // Vehicle 5 - Mitsubishi Xpander
      const VehicleModel(
        id: 'veh-005',
        customerId: 'cust-005',
        licensePlate: 'B 7890 JKL',
        model: 'Xpander',
        vehicleBrand: 'Mitsubishi',
        vehicleColor: 'Silver',
        category: 'Mobil',
        vehicleCategory: 'Mobil',
        vehicleSpecs: '1.5L, Automatic, 7 Seater',
      ),

      // Vehicle 6 - Suzuki Aerio
      const VehicleModel(
        id: 'veh-006',
        customerId: 'cust-006',
        licensePlate: 'B 2345 MNO',
        model: 'Aerio',
        vehicleBrand: 'Suzuki',
        vehicleColor: 'Biru',
        category: 'Mobil',
        vehicleCategory: 'Mobil',
        vehicleSpecs: '1.5L, Automatic, 5 Seater',
      ),

      // Vehicle 7 - Honda Vario
      const VehicleModel(
        id: 'veh-007',
        customerId: 'cust-007',
        licensePlate: 'B 6789 PQR',
        model: 'Vario 125',
        vehicleBrand: 'Honda',
        vehicleColor: 'Hitam',
        category: 'Motor',
        vehicleCategory: 'Motor',
        vehicleSpecs: '125cc, Matic',
      ),

      // Vehicle 8 - Daihatsu Xenia
      const VehicleModel(
        id: 'veh-008',
        customerId: 'cust-008',
        licensePlate: 'B 1357 STU',
        model: 'Xenia',
        vehicleBrand: 'Daihatsu',
        vehicleColor: 'Putih',
        category: 'Mobil',
        vehicleCategory: 'Mobil',
        vehicleSpecs: '1.3L, Manual, 7 Seater',
      ),

      // Vehicle 9 - Yamaha Mio
      const VehicleModel(
        id: 'veh-009',
        customerId: 'cust-001',
        licensePlate: 'B 2468 VWX',
        model: 'Mio M3',
        vehicleBrand: 'Yamaha',
        vehicleColor: 'Pink',
        category: 'Motor',
        vehicleCategory: 'Motor',
        vehicleSpecs: '125cc, Matic',
      ),

      // Vehicle 10 - Honda Brio
      const VehicleModel(
        id: 'veh-010',
        customerId: 'cust-002',
        licensePlate: 'B 9753 YZA',
        model: 'Brio',
        vehicleBrand: 'Honda',
        vehicleColor: 'Merah',
        category: 'Mobil',
        vehicleCategory: 'Mobil',
        vehicleSpecs: '1.2L, Automatic, 5 Seater',
      ),

      // Vehicle 11 - Suzuki Nex II
      const VehicleModel(
        id: 'veh-011',
        customerId: 'cust-003',
        licensePlate: 'B 4680 BCD',
        model: 'Nex II',
        vehicleBrand: 'Suzuki',
        vehicleColor: 'Kuning',
        category: 'Motor',
        vehicleCategory: 'Motor',
        vehicleSpecs: '115cc, Matic',
      ),

      // Vehicle 12 - Toyota Rush
      const VehicleModel(
        id: 'veh-012',
        customerId: 'cust-004',
        licensePlate: 'B 1593 EFG',
        model: 'Rush',
        vehicleBrand: 'Toyota',
        vehicleColor: 'Hitam',
        category: 'Mobil',
        vehicleCategory: 'Mobil',
        vehicleSpecs: '1.5L, Automatic, 7 Seater',
      ),
    ];
  }
}
