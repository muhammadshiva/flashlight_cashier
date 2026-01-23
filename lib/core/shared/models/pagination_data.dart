import '../model/pagination_model.dart';

/// Pure data model untuk pagination state
class PaginationData {
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;
  final int totalItems;
  final int startIndex;
  final int endIndex;
  final List<int> itemsPerPageOptions;
  final bool isLoading;
  final String itemLabel;

  const PaginationData({
    required this.currentPage,
    required this.totalPages,
    required this.itemsPerPage,
    required this.totalItems,
    required this.startIndex,
    required this.endIndex,
    this.itemsPerPageOptions = const [5, 10, 15, 20, 25],
    this.isLoading = false,
    required this.itemLabel,
  });

  /// Helper method untuk create copy dengan perubahan
  PaginationData copyWith({
    int? currentPage,
    int? totalPages,
    int? itemsPerPage,
    int? totalItems,
    int? startIndex,
    int? endIndex,
    List<int>? itemsPerPageOptions,
    bool? isLoading,
    String? itemLabel,
  }) {
    return PaginationData(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      totalItems: totalItems ?? this.totalItems,
      startIndex: startIndex ?? this.startIndex,
      endIndex: endIndex ?? this.endIndex,
      itemsPerPageOptions: itemsPerPageOptions ?? this.itemsPerPageOptions,
      isLoading: isLoading ?? this.isLoading,
      itemLabel: itemLabel ?? this.itemLabel,
    );
  }

  /// Create from existing PaginationModel
  factory PaginationData.fromPaginationModel(
    PaginationModel model, {
    required String itemLabel,
    bool isLoading = false,
  }) {
    return PaginationData(
      currentPage: model.page ?? 1,
      totalPages: model.lastPage ?? 1,
      itemsPerPage: model.perPage ?? 10,
      totalItems: model.total ?? 0,
      startIndex: model.firstItem ?? 0,
      endIndex: model.lastItem ?? 0,
      itemLabel: itemLabel,
      isLoading: isLoading,
    );
  }
}
