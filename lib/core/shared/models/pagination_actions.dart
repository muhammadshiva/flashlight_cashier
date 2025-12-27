import 'package:flutter/widgets.dart';

/// Pure function definitions untuk user interactions
class PaginationActions {
  final Function(int) onPageChanged;
  final Function(int) onItemsPerPageChanged;
  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;

  const PaginationActions({
    required this.onPageChanged,
    required this.onItemsPerPageChanged,
    this.onNextPage,
    this.onPreviousPage,
  });
}
