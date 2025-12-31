/// Member Vehicle entity representing a vehicle associated with a membership.
class MemberVehicle {
  final String id;
  final String? membershipId;
  final String name;
  final String plateNumber;
  final String? specs;
  final String? icon;

  const MemberVehicle({
    required this.id,
    this.membershipId,
    required this.name,
    required this.plateNumber,
    this.specs,
    this.icon,
  });

  MemberVehicle copyWith({
    String? id,
    String? membershipId,
    String? name,
    String? plateNumber,
    String? specs,
    String? icon,
  }) {
    return MemberVehicle(
      id: id ?? this.id,
      membershipId: membershipId ?? this.membershipId,
      name: name ?? this.name,
      plateNumber: plateNumber ?? this.plateNumber,
      specs: specs ?? this.specs,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MemberVehicle &&
        other.id == id &&
        other.membershipId == membershipId &&
        other.name == name &&
        other.plateNumber == plateNumber &&
        other.specs == specs &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        membershipId.hashCode ^
        name.hashCode ^
        plateNumber.hashCode ^
        specs.hashCode ^
        icon.hashCode;
  }
}
