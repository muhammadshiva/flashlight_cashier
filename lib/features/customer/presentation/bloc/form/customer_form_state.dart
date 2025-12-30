part of 'customer_form_bloc.dart';

/// State for customer form validation.
///
/// Contains:
/// - Current field values
/// - Validation status for each field
/// - Error messages for display
/// - Overall form validity
/// - Edit mode flag
class CustomerFormState extends Equatable {
  /// Current name value.
  final String name;

  /// Current phone value.
  final String phone;

  /// Current email value.
  final String email;

  /// Whether name passes validation.
  final bool isNameValid;

  /// Whether phone passes validation.
  final bool isPhoneValid;

  /// Whether email passes validation.
  final bool isEmailValid;

  /// Error message for name field.
  final String? nameError;

  /// Error message for phone field.
  final String? phoneError;

  /// Error message for email field.
  final String? emailError;

  /// Whether the form has been submitted at least once.
  /// Used to determine when to show validation errors.
  final bool isSubmitted;

  /// Whether the form is in edit mode (updating existing customer).
  final bool isEditMode;

  const CustomerFormState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.isNameValid = false,
    this.isPhoneValid = false,
    this.isEmailValid = true, // Email is optional
    this.nameError,
    this.phoneError,
    this.emailError,
    this.isSubmitted = false,
    this.isEditMode = false,
  });

  /// Returns true if all required fields are valid.
  bool get isValid => isNameValid && isPhoneValid && isEmailValid;

  /// Returns true if name is not empty.
  bool get hasName => name.isNotEmpty;

  /// Returns true if phone is not empty.
  bool get hasPhone => phone.isNotEmpty;

  /// Returns true if email is not empty.
  bool get hasEmail => email.isNotEmpty;

  /// Returns true if there's any input in the form.
  bool get hasInput => hasName || hasPhone || hasEmail;

  /// Returns the name error only if form has been submitted.
  String? get displayNameError => isSubmitted ? nameError : null;

  /// Returns the phone error only if form has been submitted.
  String? get displayPhoneError => isSubmitted ? phoneError : null;

  /// Returns the email error only if form has been submitted.
  String? get displayEmailError => isSubmitted ? emailError : null;

  CustomerFormState copyWith({
    String? name,
    String? phone,
    String? email,
    bool? isNameValid,
    bool? isPhoneValid,
    bool? isEmailValid,
    String? nameError,
    String? phoneError,
    String? emailError,
    bool? isSubmitted,
    bool? isEditMode,
  }) {
    return CustomerFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isNameValid: isNameValid ?? this.isNameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      nameError: nameError,
      phoneError: phoneError,
      emailError: emailError,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        isNameValid,
        isPhoneValid,
        isEmailValid,
        nameError,
        phoneError,
        emailError,
        isSubmitted,
        isEditMode,
      ];
}
