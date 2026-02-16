import 'package:flashlight_pos/config/constans/text_styles_const.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../work_order/domain/entities/work_order.dart';

class HistoryCard extends StatelessWidget {
  final WorkOrder workOrder;
  final Customer? customer;
  final Vehicle? vehicle;
  final VoidCallback? onTap;

  const HistoryCard({
    super.key,
    required this.workOrder,
    this.customer,
    this.vehicle,
    this.onTap,
  });

  String _shortenId(String id) {
    if (id.length > 8) {
      return '${id.substring(0, 8)}...';
    }
    return id;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final completedDate = workOrder.completedAt ?? workOrder.updatedAt;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderGray, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.dashboardCardShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Icon Circle
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: workOrder.status.toLowerCase() == 'paid'
                    ? const LinearGradient(
                        colors: [AppColors.dashboardGreen, AppColors.dashboardTeal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [AppColors.success600, AppColors.dashboardGreen],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.dashboardCardShadow,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                workOrder.status.toLowerCase() == 'paid' ? Icons.check_circle : Icons.check,
                color: AppColors.white,
                size: 24.w,
              ),
            ),
            SizedBox(width: 24.w),

            // Main Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: WO Code + Date + Status Badge
                  Row(
                    children: [
                      Text(
                        workOrder.workOrderCode,
                        style: TextStyleConst.poppinsSemiBold16
                            .copyWith(color: AppColors.blackText900),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formatDate(completedDate),
                        style: TextStyleConst.poppinsRegular14.copyWith(color: AppColors.textGray3),
                      ),
                      SizedBox(width: 12.w),
                      _StatusBadge(status: workOrder.status),
                    ],
                  ),
                  SizedBox(width: 12.w),

                  // Customer & Vehicle Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, size: 16, color: AppColors.textGray3),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    customer?.name ?? 'Cust: ${_shortenId(workOrder.customerId)}',
                                    style: TextStyleConst.poppinsSemiBold16
                                        .copyWith(color: AppColors.blackText900),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.w),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 14, color: AppColors.textGray3),
                                SizedBox(width: 8.w),
                                Text(
                                  customer?.phoneNumber ?? '-',
                                  style: TextStyleConst.poppinsRegular14
                                      .copyWith(color: AppColors.textGray3),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.w),
                            Row(
                              children: [
                                const Icon(Icons.directions_car,
                                    size: 16, color: AppColors.textGray3),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    vehicle != null
                                        ? '${vehicle!.vehicleBrand} ${vehicle!.vehicleSpecs}'
                                        : 'Vehicle: ${_shortenId(workOrder.vehicleDataId)}',
                                    style: TextStyleConst.poppinsMedium14
                                        .copyWith(color: AppColors.text800),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.w),
                            Row(
                              children: [
                                SizedBox(width: 24.w),
                                Text(
                                  vehicle?.licensePlate ?? '-',
                                  style: TextStyleConst.poppinsBold14.copyWith(
                                    color: AppColors.blackText900,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // Price Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            workOrder.totalPrice.toCurrencyFormat(),
                            style: TextStyleConst.poppinsBold20
                                .copyWith(color: AppColors.blackText900),
                          ),
                          SizedBox(height: 4.w),
                          if (workOrder.status.toLowerCase() == 'paid')
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                              decoration: BoxDecoration(
                                color: AppColors.success50,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.check_circle,
                                      size: 12, color: AppColors.success600),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Lunas',
                                    style: TextStyleConst.poppinsBold10
                                        .copyWith(color: AppColors.success600),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.w),

                  // Services
                  if (workOrder.services.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.build, size: 14, color: AppColors.textGray3),
                        SizedBox(width: 6.w),
                        Text(
                          'Layanan:',
                          style:
                              TextStyleConst.poppinsMedium12.copyWith(color: AppColors.textGray3),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.w),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.w,
                      children: workOrder.services.map((service) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                          decoration: BoxDecoration(
                            color: AppColors.dashboardBlueLight,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: AppColors.dashboardBlue.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            service.service?.name ?? 'Svc: ${_shortenId(service.serviceId)}',
                            style: TextStyleConst.poppinsMedium12
                                .copyWith(color: AppColors.dashboardBlue),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12.w),
                  ],

                  // Products (F&B)
                  if (workOrder.products.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.fastfood, size: 14, color: AppColors.textGray3),
                        SizedBox(width: 6.w),
                        Text(
                          'F&B:',
                          style:
                              TextStyleConst.poppinsMedium12.copyWith(color: AppColors.textGray3),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.w),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.w,
                      children: workOrder.products.map((product) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                          decoration: BoxDecoration(
                            color: AppColors.dashboardOrangeLight,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: AppColors.dashboardOrange.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '${product.product?.name ?? 'Prod: ${_shortenId(product.productId)}'}'
                            '${product.quantity > 1 ? ' (${product.quantity}x)' : ''}',
                            style: TextStyleConst.poppinsMedium12
                                .copyWith(color: AppColors.dashboardOrange),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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
    String text;

    switch (status.toLowerCase()) {
      case 'completed':
        bgColor = AppColors.success50;
        textColor = AppColors.success600;
        text = 'SELESAI';
        break;
      case 'paid':
        bgColor = AppColors.info50;
        textColor = AppColors.info600;
        text = 'LUNAS';
        break;
      default:
        bgColor = AppColors.backgroundGrey6;
        textColor = AppColors.textGray3;
        text = status.toUpperCase();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyleConst.poppinsBold10.copyWith(color: textColor),
      ),
    );
  }
}
