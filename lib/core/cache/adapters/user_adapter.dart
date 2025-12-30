import 'package:hive/hive.dart';

import '../../../features/auth/domain/entities/auth_entity.dart';

/// Hive type adapter for [UserEntity].
///
/// Type ID: 0 (Must be unique across all adapters)
class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 0;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      username: fields[3] as String,
      role: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(5) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

/// Hive type adapter for [AuthEntity].
///
/// Type ID: 1 (Must be unique across all adapters)
class AuthEntityAdapter extends TypeAdapter<AuthEntity> {
  @override
  final int typeId = 1;

  @override
  AuthEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthEntity(
      token: fields[0] as String,
      user: fields[1] as UserEntity,
    );
  }

  @override
  void write(BinaryWriter writer, AuthEntity obj) {
    writer
      ..writeByte(2) // Number of fields
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
