class ApiConst {
  ApiConst._();

  static String dashboardStats = '/dashboard/stats';
  static String workOrders = '/work-orders';
  static String updateWorkOrderStatus(String id) => '/work-orders/$id/status';
  static String customers = '/customers';

  // Auth
  static String login = '/auth/login';
  static String refreshToken = '/auth/refresh-token';
  static String profile = '/auth/profile';

  // Member Vehicles
  static String memberVehicles = '/member/vehicles';

  // Membership
  static String memberships = '/memberships';
  static String membership = '/membership';
  static String membershipCheck = '/membership/check';

  // Products
  static String products = '/products';

  // Reports
  static String reportGenerate = '/reports/generate';

  // Services
  static String services = '/services';

  // Store Info
  static String storeInfo = '/store/info';

  // Users
  static String users = '/users';
  static String resetPassword(String id) => '/users/$id/reset-password';

  // Vehicles
  static String vehicles = '/vehicles';
}
