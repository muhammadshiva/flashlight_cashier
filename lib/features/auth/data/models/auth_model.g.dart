// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => _AuthModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: (json['error_code'] as num).toInt(),
    );

Map<String, dynamic> _$AuthModelToJson(_AuthModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'error_code': instance.errorCode,
    };

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'email': instance.email,
      'role': instance.role,
      'status': instance.status,
    };
