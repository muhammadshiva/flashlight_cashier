import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flashlight_pos/features/customer/domain/entities/customer.dart';
import 'package:flashlight_pos/features/vehicle/domain/entities/vehicle.dart';
import 'package:flashlight_pos/features/work_order/domain/entities/work_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCard extends StatelessWidget {
  final WorkOrder order;
  final Customer? customer;
  final Vehicle? vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.customer,
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  // Design Constants
  static const _primaryColor = Color(0xFF0EA5E9);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12.r);

    return Container(
      margin: EdgeInsets.only(bottom: 2.w),
      decoration: _cardDecoration(borderRadius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              children: [
                if (isSelected) _buildSelectionStrip(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.w, 12.w, 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderRow(),
                      SizedBox(height: 8.w),
                      Divider(height: 1.w, color: Colors.blueGrey[50]),
                      SizedBox(height: 8.w),
                      _buildFooterRow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Card Decoration ───────────────────────────────────────────────

  BoxDecoration _cardDecoration(BorderRadius borderRadius) {
    return BoxDecoration(
      color: isSelected ? AppColors.slate50 : Colors.white,
      borderRadius: borderRadius,
      border: Border.all(
        color: isSelected ? _primaryColor : Colors.grey.shade200,
        width: isSelected ? 1.5.w : 1.w,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.slate500.withOpacity(isSelected ? 0.06 : 0.03),
          offset: Offset(0, 2.w),
          blurRadius: 6.r,
          spreadRadius: 0,
        ),
      ],
    );
  }

  // ─── Selection Indicator Strip ─────────────────────────────────────

  Widget _buildSelectionStrip() {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: 4.w,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0EA5E9),
              Color(0xFF38BDF8),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header Row: Vehicle + Queue + Status ──────────────────────────

  Widget _buildHeaderRow() {
    return Row(
      children: [
        _buildVehicleIcon(),
        SizedBox(width: 10.w),
        Expanded(child: _buildVehicleInfo()),
        _buildQueueBadge(),
        SizedBox(width: 12.w),
        _StatusBadge(status: order.status),
      ],
    );
  }

  Widget _buildVehicleIcon() {
    return Container(
      padding: EdgeInsets.all(7.w),
      decoration: BoxDecoration(
        color: isSelected ? _primaryColor.withOpacity(0.1) : AppColors.slate100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.directions_car_filled_rounded,
        color: isSelected ? _primaryColor : Colors.blueGrey[400],
        size: 16.w,
      ),
    );
  }

  Widget _buildVehicleInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vehicle?.licensePlate ?? 'Unknown',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.sp,
            color: const Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
        Text(
          vehicle?.vehicleBrand ?? 'No Detail',
          style: TextStyle(
            fontSize: 13.5.sp,
            color: Colors.blueGrey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildQueueBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: AppColors.slate100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.confirmation_number_outlined, size: 12.w, color: Colors.blueGrey[600]),
          SizedBox(width: 4.w),
          Text(
            'Q-${order.queueNumber}',
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Footer Row: Customer + Time + Price ───────────────────────────

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildCustomerTimeInfo()),
        _buildPriceBadge(),
      ],
    );
  }

  Widget _buildCustomerTimeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 12.w, color: Colors.blueGrey[400]),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                customer?.name ?? 'Guest',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.w),
        Row(
          children: [
            Icon(Icons.access_time_filled, size: 12.w, color: Colors.blueGrey[400]),
            SizedBox(width: 4.w),
            Text(
              order.estimatedTime,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.blueGrey[500],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: isSelected ? _primaryColor.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        order.totalPrice.toCurrencyFormat(),
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 15.5.sp,
          color: isSelected ? const Color(0xFF0369A1) : const Color(0xFF0F172A),
        ),
      ),
    );
  }
}

// ─── Status Badge ──────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _getStatusColors();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
            color: bg == AppColors.slate100 ? Colors.blueGrey[200]! : Colors.transparent),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w800,
          color: fg,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  (Color, Color) _getStatusColors() {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'paid':
        return (const Color(0xFFDCFCE7), const Color(0xFF166534));
      case 'washing':
      case 'drying':
        return (const Color(0xFFDBEAFE), const Color(0xFF1E40AF));
      case 'finishing':
        return (const Color(0xFFF3E8FF), const Color(0xFF6B21A8));
      case 'pending':
        return (const Color(0xFFFEF9C3), const Color(0xFF854D0E));
      default:
        return (AppColors.slate100, AppColors.slate600);
    }
  }
}
