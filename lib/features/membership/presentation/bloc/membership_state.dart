part of 'membership_bloc.dart';

abstract class MembershipState extends Equatable {
  const MembershipState();
  @override
  List<Object> get props => [];
}

class MembershipInitial extends MembershipState {}

class MembershipLoading extends MembershipState {}

class MembershipLoaded extends MembershipState {
  final List<Membership> memberships;
  const MembershipLoaded(this.memberships);
  @override
  List<Object> get props => [memberships];
}

class MembershipError extends MembershipState {
  final String message;
  const MembershipError(this.message);
  @override
  List<Object> get props => [message];
}

class MembershipOperationSuccess extends MembershipState {
  final String message;
  const MembershipOperationSuccess(this.message);
  @override
  List<Object> get props => [message];
}
