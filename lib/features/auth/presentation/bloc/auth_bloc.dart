import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
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

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await signUpUseCase(
        SignUpParams(
          username: event.username,
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (auth) => emit(AuthSuccess(auth: auth)),
      );
    });

    on<LogoutRequested>((event, emit) {
      // Clear token, user data, etc.
      // For now just emit Initial to trigger navigation to login
      emit(AuthInitial());
    });
  }
}
