part of 'login_form_bloc.dart';

/// State for login form validation.
///
/// Contains:
/// - Current field values
/// - Validation status for each field
/// - Error messages for display
/// - Overall form validity
class LoginFormState extends Equatable {
  /// Current username value.
  final String username;

  /// Current password value.
  final String password;

  /// Whether username passes validation.
  final bool isUsernameValid;

  /// Whether password passes validation.
  final bool isPasswordValid;

  /// Error message for username field.
  final String? usernameError;

  /// Error message for password field.
  final String? passwordError;

  /// Whether the form has been submitted at least once.
  /// Used to determine when to show validation errors.
  final bool isSubmitted;

  const LoginFormState({
    this.username = '',
    this.password = '',
    this.isUsernameValid = false,
    this.isPasswordValid = false,
    this.usernameError,
    this.passwordError,
    this.isSubmitted = false,
  });

  /// Returns true if all fields are valid.
  bool get isValid => isUsernameValid && isPasswordValid;

  /// Returns true if username is not empty.
  bool get hasUsername => username.isNotEmpty;

  /// Returns true if password is not empty.
  bool get hasPassword => password.isNotEmpty;

  /// Returns true if there's any input in the form.
  bool get hasInput => hasUsername || hasPassword;

  /// Returns the username error only if form has been submitted.
  String? get displayUsernameError => isSubmitted ? usernameError : null;

  /// Returns the password error only if form has been submitted.
  String? get displayPasswordError => isSubmitted ? passwordError : null;

  LoginFormState copyWith({
    String? username,
    String? password,
    bool? isUsernameValid,
    bool? isPasswordValid,
    String? usernameError,
    String? passwordError,
    bool? isSubmitted,
  }) {
    return LoginFormState(
      username: username ?? this.username,
      password: password ?? this.password,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      usernameError: usernameError,
      passwordError: passwordError,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        isUsernameValid,
        isPasswordValid,
        usernameError,
        passwordError,
        isSubmitted,
      ];
}
