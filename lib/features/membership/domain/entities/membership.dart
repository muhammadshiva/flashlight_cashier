import 'package:equatable/equatable.dart';

class Membership extends Equatable {
  final String id;
  final String customerId;
  final String membershipType;
  final String membershipLevel;
  final bool isActive;

  const Membership({
    required this.id,
    required this.customerId,
    required this.membershipType,
    required this.membershipLevel,
    required this.isActive,
  });

  @override
  List<Object?> get props =>
      [id, customerId, membershipType, membershipLevel, isActive];
}
