import 'package:hive/hive.dart';

import '../../../features/customer/domain/entities/customer.dart';
import '../../../features/membership/domain/entities/membership.dart';

/// Hive type adapter for [Membership].
///
/// Type ID: 2 (Must be unique across all adapters)
class MembershipAdapter extends TypeAdapter<Membership> {
  @override
  final int typeId = 2;

  @override
  Membership read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Membership(
      id: fields[0] as String,
      customerId: fields[1] as String,
      membershipType: fields[2] as String,
      membershipLevel: fields[3] as String,
      isActive: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Membership obj) {
    writer
      ..writeByte(5) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.membershipType)
      ..writeByte(3)
      ..write(obj.membershipLevel)
      ..writeByte(4)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

/// Hive type adapter for [Customer].
///
/// Type ID: 3 (Must be unique across all adapters)
/// Note: workOrders field is not cached to avoid circular dependencies
/// and excessive cache size.
class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 3;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as String,
      name: fields[1] as String,
      phoneNumber: fields[2] as String,
      email: fields[3] as String,
      membership: fields[4] as Membership?,
      // workOrders intentionally not cached
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(5) // Number of fields (excluding workOrders)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.membership);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
