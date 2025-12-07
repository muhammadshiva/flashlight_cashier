import 'package:flutter/material.dart';
import 'dashboard_sidebar.dart';
import 'dashboard_header.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          const DashboardSidebar(),
          Expanded(
            child: Column(
              children: [
                const DashboardHeader(),
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
