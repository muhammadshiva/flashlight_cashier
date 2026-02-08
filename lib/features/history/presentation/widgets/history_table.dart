import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../config/constans/text_styles_const.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../customer/domain/entities/customer.dart';
import '../../../vehicle/domain/entities/vehicle.dart';
import '../../../work_order/domain/entities/work_order.dart';
import '../../../work_order/presentation/widgets/work_order_detail_dialog.dart';

class HistoryTable extends StatelessWidget {
  final List<WorkOrder> orders;
  final Map<String, Customer> customers;
  final Map<String, Vehicle> vehicles;

  const HistoryTable({
    super.key,
    required this.orders,
    required this.customers,
    required this.vehicles,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return _buildEmptyState();

    return Column(
      children: [
        // Sticky Header
        Table(
          columnWidths: {
            0: const FlexColumnWidth(1.2),
            1: const FlexColumnWidth(2),
            2: const FlexColumnWidth(1.2),
            3: const FlexColumnWidth(1),
            4: FixedColumnWidth(100.w),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                border: const Border(
                  bottom: BorderSide(color: AppColors.slate200),
                ),
              ),
              children: const [
                _HeaderCell('WORK ORDER'),
                _HeaderCell('PELANGGAN'),
                _HeaderCell('TOTAL'),
                _HeaderCell('STATUS'),
                _HeaderCell('ACTION', align: Alignment.centerRight),
              ],
            ),
          ],
        ),
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              columnWidths: {
                0: const FlexColumnWidth(1.2),
                1: const FlexColumnWidth(2),
                2: const FlexColumnWidth(1.2),
                3: const FlexColumnWidth(1),
                4: FixedColumnWidth(100.w),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                // Data Rows
                ...orders.map((order) {
                  final customer = customers[order.customerId];
                  final vehicle = vehicles[order.vehicleDataId];
                  return TableRow(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.slate100),
                      ),
                    ),
                    children: [
                      _DataCell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${order.workOrderCode}',
                              style: TextStyleConst.poppinsSemiBold14.copyWith(
                                color: AppColors.slate800,
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              order.completedAt != null
                                  ? DateFormat('dd MMM yyyy, HH:mm').format(order.completedAt!)
                                  : '-',
                              style: TextStyleConst.poppinsRegular12.copyWith(
                                color: AppColors.slate400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _DataCell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16.r,
                              backgroundColor: AppColors.orangePrimary.withValues(
                                alpha: 0.1,
                              ),
                              child: Text(
                                (customer?.name ?? 'U').substring(0, 1).toUpperCase(),
                                style: TextStyleConst.poppinsBold12.copyWith(
                                  color: AppColors.orangePrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customer?.name ?? 'Unknown',
                                    style: TextStyleConst.poppinsMedium14.copyWith(
                                      color: AppColors.slate800,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (vehicle != null) ...[
                                    SizedBox(height: 2.w),
                                    Text(
                                      '${vehicle.licensePlate} • ${vehicle.vehicleBrand}',
                                      style: TextStyleConst.poppinsRegular12.copyWith(
                                        color: AppColors.slate500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _DataCell(
                        child: Text(
                          CurrencyFormatter.format(order.totalPrice),
                          style: const TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.w500,
                            color: AppColors.slate800,
                          ),
                        ),
                      ),
                      _DataCell(
                        child: _StatusBadge(status: order.status),
                      ),
                      _DataCell(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _ActionButton(
                            icon: Icons.visibility_outlined,
                            onTap: () {
                              showWorkOrderDetailDialog(
                                context,
                                workOrderId: order.id,
                              );
                            },
                            tooltip: 'Lihat Detail',
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history_outlined,
              size: 64.w,
              color: AppColors.textGray3.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16.w),
            Text(
              'Tidak ada riwayat work order',
              style: TextStyleConst.poppinsMedium18.copyWith(
                color: AppColors.slate500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final Alignment align;

  const _HeaderCell(this.label, {this.align = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.slate500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final Widget child;

  const _DataCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      child: child,
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _ActionButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 20.w),
      color: AppColors.slate500,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(8.w),
        hoverColor: AppColors.slate100,
      ),
    );
  }
}
