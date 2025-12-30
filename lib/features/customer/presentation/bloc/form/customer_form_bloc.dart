import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_form_event.dart';
part 'customer_form_state.dart';

/// A BLoC dedicated to customer form validation.
///
/// This BLoC is separate from [CustomerBloc] to keep form validation logic
/// isolated from business logic (CRUD operations).
///
/// Responsibilities:
/// - Validate name field
/// - Validate phone number format
/// - Validate email format (optional)
/// - Track overall form validity
/// - Clear form data on demand
class CustomerFormBloc extends Bloc<CustomerFormEvent, CustomerFormState> {
  CustomerFormBloc() : super(const CustomerFormState()) {
    on<CustomerFormNameChanged>(_onNameChanged);
    on<CustomerFormPhoneChanged>(_onPhoneChanged);
    on<CustomerFormEmailChanged>(_onEmailChanged);
    on<CustomerFormSubmitted>(_onSubmitted);
    on<CustomerFormReset>(_onReset);
    on<CustomerFormInitialize>(_onInitialize);
  }

  void _onNameChanged(
    CustomerFormNameChanged event,
    Emitter<CustomerFormState> emit,
  ) {
    final name = event.name;
    final isNameValid = _validateName(name);

    emit(state.copyWith(
      name: name,
      isNameValid: isNameValid,
      nameError: isNameValid ? null : _getNameError(name),
    ));
  }

  void _onPhoneChanged(
    CustomerFormPhoneChanged event,
    Emitter<CustomerFormState> emit,
  ) {
    final phone = event.phone;
    final isPhoneValid = _validatePhone(phone);

    emit(state.copyWith(
      phone: phone,
      isPhoneValid: isPhoneValid,
      phoneError: isPhoneValid ? null : _getPhoneError(phone),
    ));
  }

  void _onEmailChanged(
    CustomerFormEmailChanged event,
    Emitter<CustomerFormState> emit,
  ) {
    final email = event.email;
    final isEmailValid = _validateEmail(email);

    emit(state.copyWith(
      email: email,
      isEmailValid: isEmailValid,
      emailError: isEmailValid ? null : _getEmailError(email),
    ));
  }

  void _onSubmitted(
    CustomerFormSubmitted event,
    Emitter<CustomerFormState> emit,
  ) {
    // Validate all fields on submit
    final isNameValid = _validateName(state.name);
    final isPhoneValid = _validatePhone(state.phone);
    final isEmailValid = _validateEmail(state.email);

    emit(state.copyWith(
      isNameValid: isNameValid,
      isPhoneValid: isPhoneValid,
      isEmailValid: isEmailValid,
      nameError: isNameValid ? null : _getNameError(state.name),
      phoneError: isPhoneValid ? null : _getPhoneError(state.phone),
      emailError: isEmailValid ? null : _getEmailError(state.email),
      isSubmitted: true,
    ));
  }

  void _onReset(
    CustomerFormReset event,
    Emitter<CustomerFormState> emit,
  ) {
    emit(const CustomerFormState());
  }

  void _onInitialize(
    CustomerFormInitialize event,
    Emitter<CustomerFormState> emit,
  ) {
    // Initialize form with existing customer data (for editing)
    emit(CustomerFormState(
      name: event.name ?? '',
      phone: event.phone ?? '',
      email: event.email ?? '',
      isNameValid: event.name != null && _validateName(event.name!),
      isPhoneValid: event.phone != null && _validatePhone(event.phone!),
      isEmailValid: _validateEmail(event.email ?? ''),
      isEditMode: event.isEditMode,
    ));
  }

  // ============================================
  // Validation Logic
  // ============================================

  bool _validateName(String name) {
    return name.isNotEmpty && name.length >= 2;
  }

  bool _validatePhone(String phone) {
    if (phone.isEmpty) return false;

    // Remove any formatting characters
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check for valid Indonesian phone number
    // Format: 08XXXXXXXXXX or +628XXXXXXXXXX
    final phoneRegex = RegExp(r'^(\+62|62|0)8[1-9][0-9]{7,10}$');
    return phoneRegex.hasMatch(cleanPhone);
  }

  bool _validateEmail(String email) {
    // Email is optional, so empty is valid
    if (email.isEmpty) return true;

    // Simple email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  String? _getNameError(String name) {
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (name.length < 2) {
      return 'Nama minimal 2 karakter';
    }
    return null;
  }

  String? _getPhoneError(String phone) {
    if (phone.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final phoneRegex = RegExp(r'^(\+62|62|0)8[1-9][0-9]{7,10}$');

    if (!phoneRegex.hasMatch(cleanPhone)) {
      return 'Format nomor telepon tidak valid';
    }
    return null;
  }

  String? _getEmailError(String email) {
    if (email.isEmpty) return null; // Email is optional

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Format email tidak valid';
    }
    return null;
  }
}
