import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/customer/presentation/pages/customer_form_page.dart';
import '../features/customer/presentation/pages/customer_list_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/dashboard/presentation/widgets/dashboard_layout.dart';
import '../features/membership/presentation/pages/membership_form_page.dart';
import '../features/membership/presentation/pages/membership_list_page.dart';
import '../features/product/presentation/pages/product_form_page.dart';
import '../features/product/presentation/pages/product_list_page.dart';
import '../features/service/presentation/pages/service_form_page.dart';
import '../features/service/presentation/pages/service_list_page.dart';
import '../features/vehicle/presentation/pages/vehicle_form_page.dart';
import '../features/vehicle/presentation/pages/vehicle_list_page.dart';
import '../features/work_order/presentation/pages/pos_page.dart';
import '../features/work_order/presentation/pages/work_order_list_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    // Persistent Shell for Dashboard and Feature Pages
    ShellRoute(
      builder: (context, state, child) {
        return DashboardLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/work-orders',
          builder: (context, state) => const WorkOrderListPage(),
        ),
        GoRoute(
          path: '/customers',
          builder: (context, state) => const CustomerListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const CustomerFormPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/memberships',
          builder: (context, state) => const MembershipListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const MembershipFormPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/vehicles',
          builder: (context, state) => const VehicleListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const VehicleFormPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/services',
          builder: (context, state) => const ServiceListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const ServiceFormPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/products',
          builder: (context, state) => const ProductListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const ProductFormPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/pos',
      builder: (context, state) => const PosPage(),
    ),
  ],
);
