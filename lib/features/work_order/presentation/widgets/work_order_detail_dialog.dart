import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/constans/text_styles_const.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../configs/injector/injector_config.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/custom_loading.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../domain/entities/work_order.dart';
import '../bloc/detail/work_order_detail_bloc.dart';
import '../bloc/detail/work_order_detail_event.dart';
import '../bloc/detail/work_order_detail_state.dart';

/// Shows a work order detail dialog.
///
/// Displays a loading animation while fetching data from the API.
/// On success, shows the work order detail content.
/// On error, closes the dialog and shows an overlay snackbar.
Future<void> showWorkOrderDetailDialog(
  BuildContext context, {
  required String workOrderId,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => BlocProvider(
      create: (_) =>
          sl<WorkOrderDetailBloc>()..add(LoadWorkOrderDetail(workOrderId)),
      child: _WorkOrderDetailDialog(workOrderId: workOrderId),
    ),
  );
}

class _WorkOrderDetailDialog extends StatelessWidget {
  final String workOrderId;

  const _WorkOrderDetailDialog({required this.workOrderId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 1100.w, maxHeight: 700.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocConsumer<WorkOrderDetailBloc, WorkOrderDetailState>(
          listener: (context, state) {
            if (state is WorkOrderDetailError) {
              Navigator.of(context).pop();
              CustomSnackbar.showToast(
                context,
                message: state.message,
                backgroundColor: AppColors.error5,
              );
            }
          },
          builder: (context, state) {
            if (state is WorkOrderDetailLoaded) {
              return _buildLoadedContent(context, state.workOrder);
            }
            return _buildLoadingContent(context);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context),
        Expanded(
          child: CustomLoading(width: 200.w),
        ),
      ],
    );
  }

  Widget _buildLoadedContent(BuildContext context, WorkOrder wo) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context, wo: wo),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusAndQueueRow(wo),
                SizedBox(height: 20.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildInfoCard('Informasi Pelanggan', [
                      _buildInfoRow('ID Pelanggan', wo.customerId),
                    ])),
                    SizedBox(width: 16.w),
                    Expanded(child: _buildInfoCard('Informasi Kendaraan', [
                      _buildInfoRow('ID Kendaraan', wo.vehicleDataId),
                    ])),
                  ],
                ),
                SizedBox(height: 20.w),
                _buildItemsSection(wo),
                SizedBox(height: 20.w),
                _buildFinancialSection(wo),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, {WorkOrder? wo}) {
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
              Icons.receipt_long,
              size: 24,
              color: Colors.white,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Work Order',
                  style: TextStyleConst.poppinsSemiBold18.copyWith(
                    color: AppColors.blackFoundation600,
                  ),
                ),
                if (wo != null) ...[
                  4.verticalSpace,
                  Text(
                    '#${wo.workOrderCode} - ${DateFormat('dd MMM yyyy, HH:mm').format(wo.createdAt ?? DateTime.now())}',
                    style: TextStyleConst.poppinsRegular12.copyWith(
                      color: AppColors.greyFoundation300,
                    ),
                  ),
                ],
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

  Widget _buildStatusAndQueueRow(WorkOrder wo) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.slate500, size: 20.w),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: TextStyleConst.poppinsRegular12.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    _StatusBadge(status: wo.status),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.confirmation_number_outlined,
                  color: Colors.white70, size: 20.w),
              SizedBox(width: 8.w),
              Text(
                'Queue: ${wo.queueNumber}',
                style: TextStyleConst.poppinsBold16.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleConst.poppinsSemiBold14.copyWith(
              color: AppColors.slate800,
            ),
          ),
          Divider(height: 20.w, color: AppColors.slate200),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyleConst.poppinsRegular12.copyWith(
                color: AppColors.slate500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyleConst.poppinsMedium12.copyWith(
                color: AppColors.slate800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(WorkOrder wo) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Item Pekerjaan & Produk',
            style: TextStyleConst.poppinsSemiBold14.copyWith(
              color: AppColors.slate800,
            ),
          ),
          Divider(height: 20.w, color: AppColors.slate200),

          // Table header
          _buildItemHeader(),
          const Divider(height: 1, color: AppColors.slate200),

          if (wo.services.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(top: 12.w, bottom: 8.w),
              child: Text(
                'Jasa (Services)',
                style: TextStyleConst.poppinsMedium12.copyWith(
                  color: AppColors.primary600,
                ),
              ),
            ),
            ...wo.services.map((s) => _buildItemRow(
                  s.service?.name ?? s.serviceId,
                  s.quantity,
                  s.priceAtOrder,
                  s.subtotal,
                )),
          ],
          if (wo.products.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(top: 12.w, bottom: 8.w),
              child: Text(
                'Produk (F&B)',
                style: TextStyleConst.poppinsMedium12.copyWith(
                  color: AppColors.primary600,
                ),
              ),
            ),
            ...wo.products.map((p) => _buildItemRow(
                  p.product?.name ?? p.productId,
                  p.quantity,
                  p.priceAtOrder,
                  p.subtotal,
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildItemHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Item',
                style: TextStyleConst.poppinsMedium12
                    .copyWith(color: AppColors.slate500)),
          ),
          SizedBox(
            width: 60.w,
            child: Text('Qty',
                textAlign: TextAlign.center,
                style: TextStyleConst.poppinsMedium12
                    .copyWith(color: AppColors.slate500)),
          ),
          SizedBox(
            width: 120.w,
            child: Text('Harga',
                textAlign: TextAlign.right,
                style: TextStyleConst.poppinsMedium12
                    .copyWith(color: AppColors.slate500)),
          ),
          SizedBox(
            width: 120.w,
            child: Text('Subtotal',
                textAlign: TextAlign.right,
                style: TextStyleConst.poppinsMedium12
                    .copyWith(color: AppColors.slate500)),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, int qty, int price, int subtotal) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.w),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyleConst.poppinsRegular12.copyWith(
                color: AppColors.slate800,
              ),
            ),
          ),
          SizedBox(
            width: 60.w,
            child: Text(
              '${qty}x',
              textAlign: TextAlign.center,
              style: TextStyleConst.poppinsRegular12.copyWith(
                color: AppColors.slate600,
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
              price.toCurrencyFormat(),
              textAlign: TextAlign.right,
              style: TextStyleConst.poppinsRegular12.copyWith(
                color: AppColors.slate600,
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
              subtotal.toCurrencyFormat(),
              textAlign: TextAlign.right,
              style: TextStyleConst.poppinsMedium12.copyWith(
                color: AppColors.slate800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSection(WorkOrder wo) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Biaya',
                style: TextStyleConst.poppinsSemiBold14.copyWith(
                  color: AppColors.slate800,
                ),
              ),
              Text(
                wo.totalPrice.toCurrencyFormat(),
                style: TextStyleConst.poppinsBold20.copyWith(
                  color: AppColors.slate800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status Pembayaran',
                style: TextStyleConst.poppinsMedium14.copyWith(
                  color: AppColors.slate800,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
                decoration: BoxDecoration(
                  color: wo.paymentStatus == 'paid'
                      ? AppColors.success50
                      : AppColors.warning50,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  wo.paymentStatus?.toUpperCase() ?? 'PENDING',
                  style: TextStyleConst.poppinsSemiBold12.copyWith(
                    color: wo.paymentStatus == 'paid'
                        ? AppColors.success600
                        : AppColors.warning600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    final lowerStatus = status.toLowerCase();

    if (lowerStatus == 'paid') {
      bgColor = AppColors.success50;
      textColor = AppColors.success600;
      label = 'Lunas';
    } else if (lowerStatus == 'completed') {
      bgColor = AppColors.blueOriginal100;
      textColor = AppColors.blueOriginal700;
      label = 'Selesai';
    } else if (lowerStatus == 'in_progress') {
      bgColor = AppColors.warning50;
      textColor = AppColors.warning600;
      label = 'Dalam Proses';
    } else if (lowerStatus == 'created') {
      bgColor = AppColors.primary50;
      textColor = AppColors.primary600;
      label = 'Baru';
    } else if (lowerStatus == 'cancelled') {
      bgColor = AppColors.error50;
      textColor = AppColors.error600;
      label = 'Dibatalkan';
    } else {
      bgColor = AppColors.slate100;
      textColor = AppColors.slate500;
      label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
