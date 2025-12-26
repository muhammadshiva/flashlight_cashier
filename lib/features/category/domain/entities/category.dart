import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, description, isActive];
}
