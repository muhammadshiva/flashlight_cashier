// ignore_for_file: deprecated_member_use

import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../bloc/auth_bloc.dart';

/// SignUpPage - Halaman untuk registrasi pengguna baru
///
/// Halaman ini menyediakan form untuk pengguna membuat akun baru
/// dengan validasi input dan penanganan state autentikasi
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Form Keys
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Visibility States
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  /// Dispose semua text controllers untuk mencegah memory leaks
  void _disposeControllers() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  /// Handler untuk tombol sign up
  /// Melakukan validasi form dan dispatch event SignUpRequested ke AuthBloc
  void _onSignUpPressed() {
    if (!_validateForm()) return;

    if (!_isPasswordMatch()) {
      _showPasswordMismatchError();
      return;
    }

    _dispatchSignUpEvent();
  }

  /// Validasi form input
  /// Returns true jika semua field valid
  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  /// Memeriksa apakah password dan konfirmasi password cocok
  bool _isPasswordMatch() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  /// Menampilkan error message jika password tidak cocok
  void _showPasswordMismatchError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: AppColors.error600,
      ),
    );
  }

  /// Dispatch SignUpRequested event ke AuthBloc
  void _dispatchSignUpEvent() {
    context.read<AuthBloc>().add(
          SignUpRequested(
            username: _usernameController.text,
            fullName: _fullNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(context),
      body: _buildBody(context),
    );
  }

  /// Mendapatkan background color berdasarkan theme
  Color _getBackgroundColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? const Color(0xFF1F1D2B) : const Color(0xFFF3F4F6);
  }

  /// Build body widget dengan BlocConsumer untuk AuthBloc
  Widget _buildBody(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => _handleAuthState(context, state),
      builder: (context, state) => _buildContent(context, state),
    );
  }

  /// Handler untuk perubahan AuthState
  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      _showErrorSnackBar(context, state.message);
    } else if (state is AuthSuccess) {
      context.go('/dashboard');
    }
  }

  /// Menampilkan error snackbar
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error600,
      ),
    );
  }

  /// Build content utama dari halaman
  Widget _buildContent(BuildContext context, AuthState state) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _buildSignUpCard(context, state),
      ),
    );
  }

  /// Build card utama untuk form sign up
  Widget _buildSignUpCard(BuildContext context, AuthState state) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      padding: const EdgeInsets.all(40),
      decoration: _getCardDecoration(isDarkMode),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, isDarkMode),
            const SizedBox(height: 8),
            _buildLoginLink(context, isDarkMode),
            const SizedBox(height: 32),
            _buildFormFields(context, isDarkMode),
            const SizedBox(height: 32),
            _buildSubmitButton(context, state),
          ],
        ),
      ),
    );
  }

  /// Mendapatkan decoration untuk card
  BoxDecoration _getCardDecoration(bool isDarkMode) {
    return BoxDecoration(
      color: isDarkMode ? const Color(0xFF252836) : Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  /// Build header dengan title
  Widget _buildHeader(BuildContext context, bool isDarkMode) {
    return Center(
      child: Text(
        'Create Account',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : AppColors.blackText900,
            ),
      ),
    );
  }

  /// Build link ke halaman login
  Widget _buildLoginLink(BuildContext context, bool isDarkMode) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : AppColors.textGray3,
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/login'),
            child: const Text(
              "Sign in here",
              style: TextStyle(
                color: AppColors.orangePrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build semua form fields
  Widget _buildFormFields(BuildContext context, bool isDarkMode) {
    return Column(
      children: [
        _buildFullNameField(context, isDarkMode),
        const SizedBox(height: 24),
        _buildUsernameField(context, isDarkMode),
        const SizedBox(height: 24),
        _buildEmailField(context, isDarkMode),
        const SizedBox(height: 24),
        _buildPasswordField(context, isDarkMode),
        const SizedBox(height: 24),
        _buildConfirmPasswordField(context, isDarkMode),
      ],
    );
  }

  /// Build full name field
  Widget _buildFullNameField(BuildContext context, bool isDarkMode) {
    return _buildTextField(
      controller: _fullNameController,
      label: 'Full Name',
      hint: 'Enter your full name',
      isDarkMode: isDarkMode,
      validator: _validateFullName,
    );
  }

  /// Build username field
  Widget _buildUsernameField(BuildContext context, bool isDarkMode) {
    return _buildTextField(
      controller: _usernameController,
      label: 'Username',
      hint: 'Enter your username',
      isDarkMode: isDarkMode,
      validator: _validateUsername,
    );
  }

  /// Build email field
  Widget _buildEmailField(BuildContext context, bool isDarkMode) {
    return _buildTextField(
      controller: _emailController,
      label: 'Email',
      hint: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      isDarkMode: isDarkMode,
      validator: _validateEmail,
    );
  }

  /// Build password field
  Widget _buildPasswordField(BuildContext context, bool isDarkMode) {
    return _buildPasswordFieldWidget(
      controller: _passwordController,
      label: 'Password',
      isVisible: _isPasswordVisible,
      onToggleVisibility: _togglePasswordVisibility,
      isDarkMode: isDarkMode,
      validator: _validatePassword,
    );
  }

  /// Build confirm password field
  Widget _buildConfirmPasswordField(BuildContext context, bool isDarkMode) {
    return _buildPasswordFieldWidget(
      controller: _confirmPasswordController,
      label: 'Confirm Password',
      isVisible: _isConfirmPasswordVisible,
      onToggleVisibility: _toggleConfirmPasswordVisibility,
      isDarkMode: isDarkMode,
      validator: _validateConfirmPassword,
    );
  }

  /// Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  /// Toggle confirm password visibility
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  /// Build submit button
  Widget _buildSubmitButton(BuildContext context, AuthState state) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: state is AuthLoading ? null : _onSignUpPressed,
        style: _getButtonStyle(),
        child: _buildButtonChild(state),
      ),
    );
  }

  /// Mendapatkan style untuk submit button
  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.orangePrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// Build child untuk submit button
  Widget _buildButtonChild(AuthState state) {
    if (state is AuthLoading) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    }

    return const Text(
      'Sign Up',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Build generic text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDarkMode,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(label, isDarkMode),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: _getTextFieldDecoration(hint, isDarkMode),
          validator: validator,
        ),
      ],
    );
  }

  /// Build password field with visibility toggle
  Widget _buildPasswordFieldWidget({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required bool isDarkMode,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(label, isDarkMode),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          decoration: _getPasswordFieldDecoration(
              hint: '••••••••',
              isDarkMode: isDarkMode,
              isVisible: isVisible,
              onToggleVisibility: onToggleVisibility),
          validator: validator,
        ),
      ],
    );
  }

  /// Build field label
  Widget _buildFieldLabel(String label, bool isDarkMode) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: isDarkMode ? Colors.grey[300] : AppColors.textGray4,
      ),
    );
  }

  /// Mendapatkan decoration untuk text field
  InputDecoration _getTextFieldDecoration(String hint, bool isDarkMode) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: isDarkMode ? const Color(0xFF1F1D2B) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: _getInputBorder(isDarkMode),
      enabledBorder: _getInputBorder(isDarkMode),
      focusedBorder: _getFocusedInputBorder(),
    );
  }

  /// Mendapatkan decoration untuk password field
  InputDecoration _getPasswordFieldDecoration({
    required String hint,
    required bool isDarkMode,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: isDarkMode ? const Color(0xFF1F1D2B) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: _getInputBorder(isDarkMode),
      enabledBorder: _getInputBorder(isDarkMode),
      focusedBorder: _getFocusedInputBorder(),
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: onToggleVisibility,
      ),
    );
  }

  /// Mendapatkan input border untuk text field
  OutlineInputBorder _getInputBorder(bool isDarkMode) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isDarkMode ? Colors.grey[700]! : AppColors.borderGray,
      ),
    );
  }

  /// Mendapatkan focused input border
  OutlineInputBorder _getFocusedInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.orangePrimary),
    );
  }

  // Validator Methods

  /// Validator untuk full name
  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  /// Validator untuk username
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  /// Validator untuk email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }

    const emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(emailPattern).hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validator untuk password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validator untuk confirm password
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    return null;
  }
}
