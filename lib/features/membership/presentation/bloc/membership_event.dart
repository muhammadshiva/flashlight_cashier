part of 'membership_bloc.dart';

abstract class MembershipEvent extends Equatable {
  const MembershipEvent();
  @override
  List<Object> get props => [];
}

class LoadMemberships extends MembershipEvent {}

class CreateMembershipEvent extends MembershipEvent {
  final Membership membership;
  const CreateMembershipEvent(this.membership);
  @override
  List<Object> get props => [membership];
}

class DeleteMembershipEvent extends MembershipEvent {
  final String id;
  const DeleteMembershipEvent(this.id);
  @override
  List<Object> get props => [id];
}
