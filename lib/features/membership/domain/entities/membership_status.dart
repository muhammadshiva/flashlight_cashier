import 'package:equatable/equatable.dart';

class MembershipStatus extends Equatable {
  final String type; // "member" or "nonMember"
  final String message;
  final String? membershipLevel;
  final bool isLoading;

  const MembershipStatus({
    required this.type,
    required this.message,
    this.membershipLevel,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [type, message, membershipLevel, isLoading];
}
