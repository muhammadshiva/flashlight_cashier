import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final bool isDefault;
  final bool isFavorite;
  final String type;
  final bool isActive;

  const ServiceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isDefault,
    required this.isFavorite,
    required this.type,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        isDefault,
        isFavorite,
        type,
        isActive
      ];
}
