import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flashlight_pos/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceSelectionDialog extends StatelessWidget {
  const ServiceSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: 500.w,
        height: 600.w,
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Item',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate800,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: AppColors.slate500, size: 24.w),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search services or products...',
                prefixIcon: Icon(Icons.search, color: AppColors.slate400, size: 20.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.slate200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.slate200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.orangePrimary),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
            SizedBox(height: 24.w),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4.r,
                            ),
                          ],
                        ),
                        labelColor: AppColors.slate800,
                        unselectedLabelColor: AppColors.slate500,
                        dividerColor: Colors.transparent,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                        tabs: const [
                          Tab(text: 'Services'),
                          Tab(text: 'Products'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.w),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          _ServiceList(type: 'Service'),
                          _ServiceList(type: 'Product'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceList extends StatelessWidget {
  final String type;

  const _ServiceList({required this.type});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final items = type == 'Service'
        ? [
            {'name': 'Basic Wash', 'price': 35000, 'type': 'Service'},
            {'name': 'Premium Wash', 'price': 50000, 'type': 'Service'},
            {'name': 'Wax & Polish', 'price': 150000, 'type': 'Service'},
            {'name': 'Tar Remover', 'price': 45000, 'type': 'Service'},
            {'name': 'Black Again', 'price': 35000, 'type': 'Service'},
          ]
        : [
            {'name': 'Coca Cola', 'price': 10000, 'type': 'Product'},
            {'name': 'Coffee Milk', 'price': 15000, 'type': 'Product'},
            {'name': 'Air Freshener', 'price': 25000, 'type': 'Product'},
            {'name': 'Microfiber Cloth', 'price': 35000, 'type': 'Product'},
          ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.pop(context, item);
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate800,
                      ),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                Text(
                  (item['price'] as int).toCurrencyFormat(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate800,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
