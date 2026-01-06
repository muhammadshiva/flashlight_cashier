import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/features/settings/domain/entities/store_info.dart';
import 'package:flashlight_pos/features/settings/presentation/cubit/store_info/store_info_cubit.dart';
import 'package:flashlight_pos/shared/models/ui_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Store Information Section
///
/// Displays comprehensive store information with beautiful UI
/// Features:
/// - Auto-fetch data on mount (prototype mode)
/// - Loading state with shimmer effect
/// - Error handling with retry
/// - Copy-to-clipboard functionality
/// - Clean, modern card-based design
class StoreInfoSection extends StatefulWidget {
  const StoreInfoSection({super.key});

  @override
  State<StoreInfoSection> createState() => _StoreInfoSectionState();
}

class _StoreInfoSectionState extends State<StoreInfoSection> {
  @override
  void initState() {
    super.initState();
    // Auto-fetch store info when section is opened
    context.read<StoreInfoCubit>().fetchStoreInfo(isPrototype: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreInfoCubit, UIStateModel<StoreInfo>>(
      builder: (context, state) {
        return state.when(
          idle: () => _buildLoading(),
          loading: () => _buildLoading(),
          success: (storeInfo) => _buildContent(context, storeInfo),
          error: (message) => _buildError(context, message),
          empty: (message) => _buildError(context, message),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Column(
      children: [
        _buildShimmerCard(),
        16.verticalSpace,
        _buildShimmerCard(),
        16.verticalSpace,
        _buildShimmerCard(),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.greyFoundation50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary600,
              ),
            ),
            12.horizontalSpace,
            const Text(
              'Loading store information...',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.greyFoundation300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.error50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error600.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error600,
          ),
          16.verticalSpace,
          const Text(
            'Failed to load store information',
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
              context.read<StoreInfoCubit>().fetchStoreInfo(isPrototype: true);
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
    );
  }

  Widget _buildContent(BuildContext context, StoreInfo storeInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with icon
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.store,
                size: 24,
                color: AppColors.primary600,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Store Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackFoundation600,
                    ),
                  ),
                  4.verticalSpace,
                  const Text(
                    'Business details and contact information',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.greyFoundation300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        24.verticalSpace,

        // Basic Information Card
        _buildInfoCard(
          title: 'Basic Information',
          icon: Icons.business,
          children: [
            _buildInfoRow(
              label: 'Store Name',
              value: storeInfo.storeName,
              icon: Icons.storefront,
              canCopy: true,
            ),
            16.verticalSpace,
            _buildInfoRow(
              label: 'Store ID',
              value: storeInfo.id,
              icon: Icons.tag,
              canCopy: true,
            ),
          ],
        ),

        16.verticalSpace,

        // Contact Information Card
        _buildInfoCard(
          title: 'Contact Information',
          icon: Icons.contact_phone,
          children: [
            _buildInfoRow(
              label: 'Address',
              value: storeInfo.storeAddress,
              icon: Icons.location_on,
              canCopy: true,
              maxLines: 2,
            ),
            16.verticalSpace,
            _buildInfoRow(
              label: 'Phone',
              value: storeInfo.storePhone,
              icon: Icons.phone,
              canCopy: true,
            ),
            16.verticalSpace,
            _buildInfoRow(
              label: 'Email',
              value: storeInfo.storeEmail,
              icon: Icons.email,
              canCopy: true,
            ),
            if (storeInfo.storeWebsite != null) ...[
              16.verticalSpace,
              _buildInfoRow(
                label: 'Website',
                value: storeInfo.storeWebsite!,
                icon: Icons.language,
                canCopy: true,
              ),
            ],
          ],
        ),

        16.verticalSpace,

        // Legal Information Card
        _buildInfoCard(
          title: 'Legal Information',
          icon: Icons.gavel,
          children: [
            _buildInfoRow(
              label: 'Tax ID (NPWP)',
              value: storeInfo.taxId,
              icon: Icons.receipt_long,
              canCopy: true,
            ),
            16.verticalSpace,
            _buildInfoRow(
              label: 'Business License (NIB)',
              value: storeInfo.businessLicense,
              icon: Icons.verified,
              canCopy: true,
            ),
          ],
        ),

        16.verticalSpace,

        // Metadata
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.greyFoundation50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.greyFoundation300,
              ),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  'Last updated: ${_formatDateTime(storeInfo.updatedAt)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyFoundation300,
                  ),
                ),
              ),
            ],
          ),
        ),

        24.verticalSpaceFromWidth
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGray),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: AppColors.primary600,
              ),
              8.horizontalSpace,
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackFoundation600,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
    bool canCopy = false,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.greyFoundation50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.greyFoundation300,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyFoundation300,
                ),
              ),
              4.verticalSpace,
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackFoundation600,
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (canCopy) ...[
          8.horizontalSpace,
          InkWell(
            onTap: () => _copyToClipboard(value),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.greyFoundation50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.copy,
                size: 14,
                color: AppColors.greyFoundation300,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.white, size: 20),
            12.horizontalSpace,
            const Text('Copied to clipboard'),
          ],
        ),
        backgroundColor: AppColors.success600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
