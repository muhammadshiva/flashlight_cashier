import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;

  const Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, email];
}
