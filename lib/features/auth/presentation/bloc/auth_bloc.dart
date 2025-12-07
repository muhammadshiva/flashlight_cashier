import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase(
        LoginParams(username: event.username, password: event.password),
      );
      result.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (auth) => emit(AuthSuccess(auth: auth)),
      );
    });
  }
}
