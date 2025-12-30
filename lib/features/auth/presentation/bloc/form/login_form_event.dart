part of 'login_form_bloc.dart';

/// Base class for all login form events.
abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when username field changes.
class LoginFormUsernameChanged extends LoginFormEvent {
  final String username;

  const LoginFormUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

/// Event triggered when password field changes.
class LoginFormPasswordChanged extends LoginFormEvent {
  final String password;

  const LoginFormPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

/// Event triggered when form is submitted.
///
/// This validates all fields and marks the form as submitted,
/// which triggers showing validation errors.
class LoginFormSubmitted extends LoginFormEvent {
  const LoginFormSubmitted();
}

/// Event to reset the form to initial state.
class LoginFormReset extends LoginFormEvent {
  const LoginFormReset();
}
