import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/configs/injector/injector_config.dart';
import 'package:flashlight_pos/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile Dialog dengan form edit
///
/// Features:
/// - Auto-fetch data on mount (prototype mode)
/// - Editable form fields
/// - Loading state
/// - Error handling
/// - Save functionality
class ProfileDialog extends StatefulWidget {
  const ProfileDialog({super.key});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers
  late TextEditingController _storeNameController;
  late TextEditingController _storeAddressController;
  late TextEditingController _storePhoneController;
  late TextEditingController _storeEmailController;
  late TextEditingController _storeWebsiteController;
  late TextEditingController _taxIdController;
  late TextEditingController _businessLicenseController;

  // FocusNodes
  final FocusNode _storeNameFocus = FocusNode();
  final FocusNode _storeAddressFocus = FocusNode();
  final FocusNode _storePhoneFocus = FocusNode();
  final FocusNode _storeEmailFocus = FocusNode();
  final FocusNode _storeWebsiteFocus = FocusNode();
  final FocusNode _taxIdFocus = FocusNode();
  final FocusNode _businessLicenseFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    // Auto-fetch profile when dialog is opened
    context.read<ProfileCubit>().fetchProfile(isPrototype: true);
  }

  void _initializeControllers() {
    _storeNameController = TextEditingController();
    _storeAddressController = TextEditingController();
    _storePhoneController = TextEditingController();
    _storeEmailController = TextEditingController();
    _storeWebsiteController = TextEditingController();
    _taxIdController = TextEditingController();
    _businessLicenseController = TextEditingController();
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _storeAddressController.dispose();
    _storePhoneController.dispose();
    _storeEmailController.dispose();
    _storeWebsiteController.dispose();
    _taxIdController.dispose();
    _businessLicenseController.dispose();
    _storeNameFocus.dispose();
    _storeAddressFocus.dispose();
    _storePhoneFocus.dispose();
    _storeEmailFocus.dispose();
    _storeWebsiteFocus.dispose();
    _taxIdFocus.dispose();
    _businessLicenseFocus.dispose();
    super.dispose();
  }

  void _populateControllers(StoreInfo storeInfo) {
    _storeNameController.text = storeInfo.storeName;
    _storeAddressController.text = storeInfo.storeAddress;
    _storePhoneController.text = storeInfo.storePhone;
    _storeEmailController.text = storeInfo.storeEmail;
    _storeWebsiteController.text = storeInfo.storeWebsite ?? '';
    _taxIdController.text = storeInfo.taxId;
    _businessLicenseController.text = storeInfo.businessLicense;
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final currentState = context.read<ProfileCubit>().state;
    StoreInfo? storeInfo;

    currentState.maybeWhen(
      success: (data) => storeInfo = data,
      orElse: () => storeInfo = null,
    );

    if (storeInfo == null) {
      return;
    }

    await context.read<ProfileCubit>().updateProfileData(
          id: storeInfo?.id ?? "",
          storeName: _storeNameController.text.trim(),
          storeAddress: _storeAddressController.text.trim(),
          storePhone: _storePhoneController.text.trim(),
          storeEmail: _storeEmailController.text.trim(),
          storeLogo: storeInfo?.storeLogo,
          storeWebsite: _storeWebsiteController.text.trim().isEmpty
              ? null
              : _storeWebsiteController.text.trim(),
          taxId: _taxIdController.text.trim(),
          businessLicense: _businessLicenseController.text.trim(),
        );

    // Show success message and close dialog
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.white, size: 20),
              SizedBox(width: 12),
              Text('Profile updated successfully'),
            ],
          ),
          backgroundColor: AppColors.success600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 70.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 600.w,
        constraints: BoxConstraints(
          maxHeight: 800.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(),

            // Content
            Expanded(
              child: _buildContent(),
            ),

            // Footer with buttons
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person,
              size: 24,
              color: Colors.white,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackFoundation600,
                  ),
                ),
                4.verticalSpace,
                const Text(
                  'Update your store information',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.greyFoundation300,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: AppColors.blackFoundation600),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<ProfileCubit, UIStateModel<StoreInfo>>(
      listener: (context, state) {
        state.whenOrNull(
          success: (storeInfo) {
            // Populate controllers when data is loaded
            _populateControllers(storeInfo);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error600,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return state.when(
          idle: () => _buildLoading(),
          loading: () => _buildLoading(),
          success: (storeInfo) => _buildForm(context, storeInfo),
          error: (message) => _buildError(message),
          empty: (message) => _buildError(message),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary600,
          ),
          16.verticalSpace,
          const Text(
            'Loading profile...',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.greyFoundation300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error600,
            ),
            16.verticalSpace,
            const Text(
              'Failed to load profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.red_1,
              ),
            ),
            8.verticalSpace,
            Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.red_2,
              ),
              textAlign: TextAlign.center,
            ),
            24.verticalSpace,
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProfileCubit>().fetchProfile(isPrototype: true);
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, StoreInfo storeInfo) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information
            _buildSectionTitle('Basic Information'),
            16.verticalSpace,
            _buildTextField(
              controller: _storeNameController,
              focusNode: _storeNameFocus,
              label: 'Store Name',
              icon: Icons.storefront,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Store name is required';
                }
                return null;
              },
            ),
            16.verticalSpace,
            _buildTextField(
              controller: _storeAddressController,
              focusNode: _storeAddressFocus,
              label: 'Store Address',
              icon: Icons.location_on,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Store address is required';
                }
                return null;
              },
            ),

            24.verticalSpace,

            // Contact Information
            _buildSectionTitle('Contact Information'),
            16.verticalSpace,
            _buildTextField(
              controller: _storePhoneController,
              focusNode: _storePhoneFocus,
              label: 'Phone Number',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Phone number is required';
                }
                if (value.length < 10) {
                  return 'Phone number must be at least 10 digits';
                }
                return null;
              },
            ),
            16.verticalSpace,
            _buildTextField(
              controller: _storeEmailController,
              focusNode: _storeEmailFocus,
              label: 'Email Address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            16.verticalSpace,
            _buildTextField(
              controller: _storeWebsiteController,
              focusNode: _storeWebsiteFocus,
              label: 'Website (Optional)',
              icon: Icons.language,
              keyboardType: TextInputType.url,
            ),

            24.verticalSpace,

            // Legal Information
            _buildSectionTitle('Legal Information'),
            16.verticalSpace,
            _buildTextField(
              controller: _taxIdController,
              focusNode: _taxIdFocus,
              label: 'Tax ID (NPWP)',
              icon: Icons.receipt_long,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tax ID is required';
                }
                return null;
              },
            ),
            16.verticalSpace,
            _buildTextField(
              controller: _businessLicenseController,
              focusNode: _businessLicenseFocus,
              label: 'Business License (NIB)',
              icon: Icons.verified,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Business license is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.blackFoundation600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppColors.greyFoundation300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error600),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error600, width: 2),
        ),
        filled: true,
        fillColor: AppColors.greyFoundation50.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.blackFoundation600,
      ),
    );
  }

  Widget _buildFooter() {
    return BlocBuilder<ProfileCubit, UIStateModel<StoreInfo>>(
      builder: (context, state) {
        bool isLoading = false;
        state.maybeWhen(
          loading: () => isLoading = true,
          orElse: () => isLoading = false,
        );

        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: const BoxDecoration(
            color: AppColors.greyFoundation50,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.blackFoundation600,
                  side: const BorderSide(color: AppColors.borderGray),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Cancel'),
              ),
              16.horizontalSpace,
              ElevatedButton(
                onPressed: isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Save Changes'),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Profile Dialog dengan ProfileCubit yang sudah disediakan
/// Digunakan untuk menghindari ProviderNotFoundException
class ProfileDialogWithCubit extends StatelessWidget {
  const ProfileDialogWithCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileCubit>(),
      child: const ProfileDialog(),
    );
  }
}
