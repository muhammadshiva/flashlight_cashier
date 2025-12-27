import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/session_timeout_listener.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/customer/domain/entities/customer.dart';
import '../../features/customer/presentation/pages/customer_form_page.dart';
import '../../features/customer/presentation/pages/customer_list_page.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/dashboard/presentation/bloc/dashboard_event.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/widgets/dashboard_layout.dart';
import '../../features/history/presentation/bloc/history_bloc.dart';
import '../../features/history/presentation/bloc/history_event.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/membership/presentation/pages/membership_form_page.dart';
import '../../features/membership/presentation/pages/membership_list_page.dart';
import '../../features/product/domain/entities/product.dart';
import '../../features/product/presentation/pages/product_form_page.dart';
import '../../features/product/presentation/pages/product_list_page.dart';
import '../../features/category/domain/entities/category.dart';
import '../../features/category/presentation/pages/category_form_page.dart';
import '../../features/category/presentation/pages/category_list_page.dart';
import '../../features/stock/presentation/pages/stock_control_page.dart';
import '../../features/report/presentation/pages/reports_page.dart';
import '../../features/service/presentation/pages/service_form_page.dart';
import '../../features/service/presentation/pages/service_list_page.dart';
import '../../features/user/domain/entities/user.dart';
import '../../features/user/presentation/pages/user_form_page.dart';
import '../../features/user/presentation/pages/user_list_page.dart';
import '../../features/vehicle/presentation/pages/vehicle_form_page.dart';
import '../../features/vehicle/presentation/pages/vehicle_list_page.dart';
import '../../features/work_order/presentation/pages/pos_page.dart';
import '../../features/work_order/presentation/pages/work_order_detail_page.dart';
import '../../injection_container.dart' as di;
import '../routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
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
            path: AppRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.workOrders,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => di.sl<HistoryBloc>()..add(LoadHistory()),
                child: const HistoryPage(),
              ),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childId,
                builder: (context, state) => WorkOrderDetailPage(
                  workOrderId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.customers,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CustomerListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const CustomerFormPage(),
              ),
              GoRoute(
                path: AppRoutes.childIdEdit,
                builder: (context, state) {
                  final customer = state.extra as Customer?;
                  return CustomerFormPage(customer: customer);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.memberships,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MembershipListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const MembershipFormPage(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.vehicles,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: VehicleListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const VehicleFormPage(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.services,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ServiceListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const ServiceFormPage(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.products,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProductListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const ProductFormPage(),
              ),
              GoRoute(
                path: AppRoutes.childIdEdit,
                builder: (context, state) {
                  final product = state.extra as Product?;
                  return ProductFormPage(product: product);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.categories,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CategoryListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const CategoryFormPage(),
              ),
              GoRoute(
                path: AppRoutes.childIdEdit,
                builder: (context, state) {
                  final category = state.extra as Category?;
                  return CategoryFormPage(category: category);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.stockControl,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StockControlPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.users,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: UserListPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.childNew,
                builder: (context, state) => const UserFormPage(),
              ),
              GoRoute(
                path: AppRoutes.childIdEdit,
                builder: (context, state) {
                  final user = state.extra as User?;
                  return UserFormPage(user: user);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.reports,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ReportsPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.pos,
        builder: (context, state) => const PosPage(),
      ),
    ],
  );
}
