import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/membership.dart';
import '../../domain/usecases/membership_usecases.dart';

part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final GetMemberships getMemberships;
  final CreateMembership createMembership;
  final DeleteMembership deleteMembership;

  MembershipBloc({
    required this.getMemberships,
    required this.createMembership,
    required this.deleteMembership,
  }) : super(MembershipInitial()) {
    on<LoadMemberships>((event, emit) async {
      emit(MembershipLoading());
      final result = await getMemberships(NoParams());
      result.fold(
        (failure) => emit(MembershipError(failure.message)),
        (memberships) => emit(MembershipLoaded(memberships)),
      );
    });

    on<CreateMembershipEvent>((event, emit) async {
      emit(MembershipLoading());
      final result = await createMembership(event.membership);
      result.fold(
        (failure) => emit(MembershipError(failure.message)),
        (_) {
          emit(const MembershipOperationSuccess("Membership created"));
          add(LoadMemberships());
        },
      );
    });

    on<DeleteMembershipEvent>((event, emit) async {
      emit(MembershipLoading());
      final result = await deleteMembership(event.id);
      result.fold(
        (failure) => emit(MembershipError(failure.message)),
        (_) {
          emit(const MembershipOperationSuccess("Membership deleted"));
          add(LoadMemberships());
        },
      );
    });
  }
}
