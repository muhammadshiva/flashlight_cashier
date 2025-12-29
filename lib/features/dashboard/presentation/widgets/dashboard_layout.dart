import 'package:flutter/material.dart';
import 'dashboard_top_navigation.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            const DashboardTopNavigation(),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
