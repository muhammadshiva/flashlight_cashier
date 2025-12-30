import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC for authentication operations.
///
/// Handles login, logout, and session management.
/// Uses [NetworkInfo] to check connectivity before operations.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final NetworkInfo networkInfo;

  AuthBloc({
    required this.loginUseCase,
    required this.networkInfo,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Check network connectivity first
    if (!await networkInfo.isConnected) {
      emit(const AuthFailure(
        message: 'Tidak ada koneksi internet. Periksa koneksi Anda.',
      ));
      return;
    }

    final result = await loginUseCase(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (auth) => emit(AuthSuccess(auth: auth)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Clear token, user data, etc.
    // Note: Actual logout logic would be in repository
    emit(AuthInitial());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Check if user has valid cached token
    // This would typically check with repository
    // For now, just emit initial state
    emit(AuthInitial());
  }
}
