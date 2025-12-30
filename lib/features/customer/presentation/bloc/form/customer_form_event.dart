part of 'customer_form_bloc.dart';

/// Base class for all customer form events.
abstract class CustomerFormEvent extends Equatable {
  const CustomerFormEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize form with existing customer data (for editing).
class CustomerFormInitialize extends CustomerFormEvent {
  final String? name;
  final String? phone;
  final String? email;
  final bool isEditMode;

  const CustomerFormInitialize({
    this.name,
    this.phone,
    this.email,
    this.isEditMode = false,
  });

  @override
  List<Object?> get props => [name, phone, email, isEditMode];
}

/// Event triggered when name field changes.
class CustomerFormNameChanged extends CustomerFormEvent {
  final String name;

  const CustomerFormNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

/// Event triggered when phone field changes.
class CustomerFormPhoneChanged extends CustomerFormEvent {
  final String phone;

  const CustomerFormPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

/// Event triggered when email field changes.
class CustomerFormEmailChanged extends CustomerFormEvent {
  final String email;

  const CustomerFormEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

/// Event triggered when form is submitted.
///
/// This validates all fields and marks the form as submitted,
/// which triggers showing validation errors.
class CustomerFormSubmitted extends CustomerFormEvent {
  const CustomerFormSubmitted();
}

/// Event to reset the form to initial state.
class CustomerFormReset extends CustomerFormEvent {
  const CustomerFormReset();
}
