import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../work_order/domain/entities/work_order.dart';

class WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;
  final int index;
  final Customer? customer;
  final Vehicle? vehicle;
  final VoidCallback? onActionPressed;

  const WorkOrderCard({
    super.key,
    required this.workOrder,
    required this.index,
    this.customer,
    this.vehicle,
    this.onActionPressed,
  });

  String _shortenId(String id) {
    if (id.length > 8) {
      return '${id.substring(0, 8)}...';
    }
    return id;
  }

  String _getActionButtonLabel() {
    switch (workOrder.status.toLowerCase()) {
      case 'queued':
        return 'Mulai Cuci';
      case 'washing':
        return 'Mulai Kering';
      case 'drying':
        return 'Mulai Inspeksi';
      case 'inspection':
        return 'Selesai';
      case 'completed':
        return 'Proses Bayar';
      case 'paid':
        return 'Lihat Detail';
      default:
        return 'Proses';
    }
  }

  IconData _getActionButtonIcon() {
    switch (workOrder.status.toLowerCase()) {
      case 'queued':
        return Icons.local_car_wash;
      case 'washing':
        return Icons.air;
      case 'drying':
        return Icons.fact_check;
      case 'inspection':
        return Icons.check_circle;
      case 'completed':
        return Icons.payment;
      case 'paid':
        return Icons.visibility;
      default:
        return Icons.arrow_forward;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderGray, width: 0.5.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.dashboardCardShadow,
            blurRadius: 8.r,
            offset: Offset(0, 2.w),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Queue Number Circle
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.dashboardBlue, AppColors.dashboardTeal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.dashboardCardShadow,
                  blurRadius: 8.r,
                  offset: Offset(0, 2.w),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              workOrder.queueNumber,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 24.w),

          // Main Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: ID + Time + Tags
                Row(
                  children: [
                    Text(
                      workOrder.workOrderCode,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slate800,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      workOrder.createdAt != null
                          ? DateFormat('HH:mm').format(workOrder.createdAt!)
                          : '-',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.slate500,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    _StatusBadge(status: workOrder.status),
                    if (workOrder.estimatedTime.isNotEmpty) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                        decoration: BoxDecoration(
                          color: AppColors.slate100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, size: 12.w, color: AppColors.slate500),
                            SizedBox(width: 4.w),
                            Text(
                              workOrder.estimatedTime,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.slate500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 12.w),

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
                              Icon(Icons.person, size: 16.w, color: AppColors.slate500),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  customer?.name ?? 'Cust: ${_shortenId(workOrder.customerId)}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.slate800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.w),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 14.w, color: AppColors.slate500),
                              SizedBox(width: 8.w),
                              Text(
                                customer?.phoneNumber ?? '-',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.slate500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.w),
                          Row(
                            children: [
                              Icon(Icons.directions_car, size: 16.w, color: AppColors.slate500),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  vehicle != null
                                      ? '${vehicle!.vehicleBrand} ${vehicle!.vehicleSpecs}'
                                      : 'Vehicle: ${_shortenId(workOrder.vehicleDataId)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.slate600,
                                  ),
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
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.slate800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Action Button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onActionPressed,
                          icon: Icon(_getActionButtonIcon(), size: 18.w),
                          label: Text(_getActionButtonLabel()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getActionButtonColor(),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0,
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
                      Icon(Icons.build, size: 14.w, color: AppColors.slate400),
                      SizedBox(width: 6.w),
                      Text(
                        'Layanan:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate400,
                        ),
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
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: const Color(0xFFBFDBFE),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          service.service?.name ?? 'Svc: ${_shortenId(service.serviceId)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E40AF),
                          ),
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
                      Icon(Icons.fastfood, size: 14.w, color: AppColors.slate400),
                      SizedBox(width: 6.w),
                      Text(
                        'F&B:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate400,
                        ),
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
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: const Color(0xFFFDE68A),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          '${product.product?.name ?? 'Prod: ${_shortenId(product.productId)}'}'
                          '${product.quantity > 1 ? ' (${product.quantity}x)' : ''}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 12.w),
                ],

                // Price
                Row(
                  children: [
                    Text(
                      workOrder.totalPrice.toCurrencyFormat(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slate800,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Show products count as upsell indicator
                    if (workOrder.products.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.local_offer, size: 12.w, color: const Color(0xFFD97706)),
                            SizedBox(width: 4.w),
                            Text(
                              'Upsell',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFD97706),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionButtonColor() {
    switch (workOrder.status.toLowerCase()) {
      case 'queued':
        return AppColors.dashboardBlue; // Blue
      case 'washing':
        return AppColors.dashboardOrange; // Orange
      case 'drying':
        return AppColors.dashboardTeal; // Teal
      case 'inspection':
        return AppColors.dashboardGreen; // Green
      case 'completed':
        return AppColors.success600; // Dark Green
      case 'paid':
        return AppColors.textGray3; // Gray
      default:
        return AppColors.blackText900; // Default Dark
    }
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
      case 'queued':
        bgColor = AppColors.dashboardBlueLight;
        textColor = AppColors.dashboardBlue;
        text = 'ANTRI';
        break;
      case 'washing':
        bgColor = AppColors.dashboardOrangeLight;
        textColor = AppColors.dashboardOrange;
        text = 'CUCI';
        break;
      case 'drying':
        bgColor = AppColors.dashboardTealLight;
        textColor = AppColors.dashboardTeal;
        text = 'KERING';
        break;
      case 'inspection':
        bgColor = AppColors.dashboardGreenLight;
        textColor = AppColors.dashboardGreen;
        text = 'INSPEKSI';
        break;
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
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
