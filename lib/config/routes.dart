import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/customer/presentation/pages/customer_form_page.dart';
import '../features/customer/presentation/pages/customer_list_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/dashboard/presentation/widgets/dashboard_layout.dart';
import '../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../features/dashboard/presentation/bloc/dashboard_event.dart';
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
import '../features/work_order/presentation/pages/work_order_detail_page.dart';
import '../features/user/presentation/pages/user_list_page.dart';
import '../features/user/presentation/pages/user_form_page.dart';
import '../features/user/domain/entities/user.dart';
import '../features/customer/domain/entities/customer.dart';
import '../features/product/domain/entities/product.dart';
import '../features/report/presentation/pages/reports_page.dart';
import '../core/widgets/session_timeout_listener.dart';
import '../injection_container.dart' as di;

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
        return BlocProvider<DashboardBloc>(
          create: (context) => di.sl<DashboardBloc>()..add(LoadDashboardStats()),
          child: Builder(
            builder: (context) {
              return SessionTimeoutListener(
                child: DashboardLayout(child: child),
              );
            },
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/work-orders',
          builder: (context, state) => const WorkOrderListPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => WorkOrderDetailPage(
                workOrderId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/customers',
          builder: (context, state) => const CustomerListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const CustomerFormPage(),
            ),
            GoRoute(
              path: ':id/edit',
              builder: (context, state) {
                final customer = state.extra as Customer?;
                return CustomerFormPage(customer: customer);
              },
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
            GoRoute(
              path: ':id/edit',
              builder: (context, state) {
                final product = state.extra as Product?;
                return ProductFormPage(product: product);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/users',
          builder: (context, state) => const UserListPage(),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const UserFormPage(),
            ),
            GoRoute(
              path: ':id/edit',
              builder: (context, state) {
                final user = state.extra as User?;
                return UserFormPage(user: user);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/pos',
      builder: (context, state) => const PosPage(),
    ),
  ],
);
