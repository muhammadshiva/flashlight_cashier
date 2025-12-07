// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/customer.dart';
import 'dart:convert';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

@freezed
abstract class CustomerModel with _$CustomerModel {
  const CustomerModel._();

  const factory CustomerModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "phoneNumber") required String phoneNumber,
    @JsonKey(name: "email") required String email,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Customer toEntity() => Customer(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
      );
}
