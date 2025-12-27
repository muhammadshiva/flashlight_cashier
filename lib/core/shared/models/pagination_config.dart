import 'pagination_actions.dart';
import 'pagination_data.dart';
import 'pagination_theme.dart';

/// Complete configuration untuk pagination component
class PaginationConfig {
  final PaginationData data;
  final PaginationActions actions;
  final PaginationTheme? theme;
  final bool showItemsPerPageDropdown;
  final bool showInfoCounter;
  final bool showPageNumbers;

  const PaginationConfig({
    required this.data,
    required this.actions,
    this.theme,
    this.showItemsPerPageDropdown = true,
    this.showInfoCounter = true,
    this.showPageNumbers = true,
  });
}
