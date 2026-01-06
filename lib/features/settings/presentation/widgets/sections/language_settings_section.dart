import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/language_settings/language_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Language Settings Section Widget
///
/// Displays and allows editing of language settings
class LanguageSettingsSection extends StatelessWidget {
  const LanguageSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageSettingsCubit(
        settingsBloc: context.read<SettingsBloc>(),
      ),
      child: const _LanguageSettingsForm(),
    );
  }
}

class _LanguageSettingsForm extends StatelessWidget {
  const _LanguageSettingsForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageSettingsCubit, LanguageSettingsState>(
      listener: (context, state) {
        // Show save confirmation or error messages if needed
        if (!state.isSaving && !state.isDirty) {
          // Settings were saved successfully
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pengaturan bahasa berhasil disimpan'),
              backgroundColor: AppColors.success600,
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Language Selection
          _buildSectionTitle('Bahasa'),
          _buildLanguageDropdown(context),
          SizedBox(height: 32.h),

          // Action Buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.blackFoundation600,
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return BlocBuilder<LanguageSettingsCubit, LanguageSettingsState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          initialValue: state.language,
          decoration: InputDecoration(
            hintText: 'Pilih Bahasa',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.greyBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.greyBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.orangePrimary),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
          items: const [
            DropdownMenuItem(value: 'id_ID', child: Text('Bahasa Indonesia')),
            DropdownMenuItem(value: 'en_US', child: Text('English')),
            DropdownMenuItem(value: 'zh_CN', child: Text('中文')),
            DropdownMenuItem(value: 'ja_JP', child: Text('日本語')),
          ],
          onChanged: (value) {
            if (value != null) {
              context.read<LanguageSettingsCubit>().updateLanguage(value);
            }
          },
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return BlocBuilder<LanguageSettingsCubit, LanguageSettingsState>(
      builder: (context, state) {
        return Row(
          children: [
            // Save Button
            Expanded(
              child: ElevatedButton(
                onPressed: state.isDirty && !state.isSaving
                    ? () => context.read<LanguageSettingsCubit>().saveSettings()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangePrimary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: state.isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Simpan'),
              ),
            ),
            SizedBox(width: 16.w),

            // Reset Button
            OutlinedButton(
              onPressed: state.isDirty && !state.isSaving
                  ? () => context.read<LanguageSettingsCubit>().discardChanges()
                  : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textGray2,
                side: const BorderSide(color: AppColors.greyBorder),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
