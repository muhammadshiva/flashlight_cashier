import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceSelectionDialog extends StatelessWidget {
  const ServiceSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Item',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search services or products...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.orangePrimary),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        labelColor: const Color(0xFF1E293B),
                        unselectedLabelColor: const Color(0xFF64748B),
                        dividerColor: Colors.transparent,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w600),
                        tabs: const [
                          Tab(text: 'Services'),
                          Tab(text: 'Products'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
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
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Rp ${item['price']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
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
