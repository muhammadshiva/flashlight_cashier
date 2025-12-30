import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

/// A BLoC dedicated to login form validation.
///
/// This BLoC is separate from [AuthBloc] to keep form validation logic
/// isolated from business logic (authentication).
///
/// Responsibilities:
/// - Validate username/email format
/// - Validate password requirements
/// - Track overall form validity
/// - Clear form data on demand
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(const LoginFormState()) {
    on<LoginFormUsernameChanged>(_onUsernameChanged);
    on<LoginFormPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onSubmitted);
    on<LoginFormReset>(_onReset);
  }

  void _onUsernameChanged(
    LoginFormUsernameChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final username = event.username;
    final isUsernameValid = _validateUsername(username);

    emit(state.copyWith(
      username: username,
      isUsernameValid: isUsernameValid,
      usernameError: isUsernameValid ? null : _getUsernameError(username),
    ));
  }

  void _onPasswordChanged(
    LoginFormPasswordChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final password = event.password;
    final isPasswordValid = _validatePassword(password);

    emit(state.copyWith(
      password: password,
      isPasswordValid: isPasswordValid,
      passwordError: isPasswordValid ? null : _getPasswordError(password),
    ));
  }

  void _onSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginFormState> emit,
  ) {
    // Validate all fields on submit
    final isUsernameValid = _validateUsername(state.username);
    final isPasswordValid = _validatePassword(state.password);

    emit(state.copyWith(
      isUsernameValid: isUsernameValid,
      isPasswordValid: isPasswordValid,
      usernameError: isUsernameValid ? null : _getUsernameError(state.username),
      passwordError: isPasswordValid ? null : _getPasswordError(state.password),
      isSubmitted: true,
    ));
  }

  void _onReset(
    LoginFormReset event,
    Emitter<LoginFormState> emit,
  ) {
    emit(const LoginFormState());
  }

  // ============================================
  // Validation Logic
  // ============================================

  bool _validateUsername(String username) {
    return username.isNotEmpty && username.length >= 3;
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  String? _getUsernameError(String username) {
    if (username.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (username.length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  String? _getPasswordError(String password) {
    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (password.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }
}
