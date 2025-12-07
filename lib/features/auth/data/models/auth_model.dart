// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import '../../domain/entities/auth_entity.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

@freezed
abstract class AuthModel with _$AuthModel {
  const AuthModel._();

  const factory AuthModel({
    @JsonKey(name: "success") required bool success,
    @JsonKey(name: "message") required String message,
    @JsonKey(name: "data") required Data data,
    @JsonKey(name: "error_code") required int errorCode,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  AuthEntity toEntity() => AuthEntity(
        token: data.accessToken,
        user: data.user.toEntity(),
      );
}

@freezed
abstract class Data with _$Data {
  const factory Data({
    @JsonKey(name: "accessToken") required String accessToken,
    @JsonKey(name: "refreshToken") required String refreshToken,
    @JsonKey(name: "user") required User user,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "username") required String username,
    @JsonKey(name: "fullName") required String fullName,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "role") required String role,
    @JsonKey(name: "status") required String status,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  UserEntity toEntity() => UserEntity(
        id: id,
        name: fullName,
        email: email,
        username: username,
        role: role,
      );
}
