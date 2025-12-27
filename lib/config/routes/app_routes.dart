class AppRoutes {
  AppRoutes._();

  // Auth
  static const String login = '/login';
  static const String signUp = '/signup';

  // Dashboard & Main
  static const String dashboard = '/dashboard';
  static const String pos = '/pos';

  // Work Orders & History
  static const String workOrders = '/work-orders';
  static String workOrderDetail(String id) => '/work-orders/$id';

  // Customers
  static const String customers = '/customers';
  static const String customerNew = '/customers/new';
  static String customerEdit(String id) => '/customers/$id/edit';

  // Memberships
  static const String memberships = '/memberships';
  static const String membershipNew = '/memberships/new';

  // Vehicles
  static const String vehicles = '/vehicles';
  static const String vehicleNew = '/vehicles/new';

  // Services
  static const String services = '/services';
  static const String serviceNew = '/services/new';

  // Products
  static const String products = '/products';
  static const String productNew = '/products/new';
  static String productEdit(String id) => '/products/$id/edit';

  // Categories
  static const String categories = '/categories';
  static const String categoryNew = '/categories/new';
  static String categoryEdit(String id) => '/categories/$id/edit';

  // Stock Control
  static const String stockControl = '/stock-control';

  // Users
  static const String users = '/users';
  static const String userNew = '/users/new';
  static String userEdit(String id) => '/users/$id/edit';

  // Reports
  static const String reports = '/reports';

  // Child route paths (relative)
  static const String childNew = 'new';
  static const String childIdEdit = ':id/edit';
  static const String childId = ':id';
}
