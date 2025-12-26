part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final List<Category> allCategories; // For pagination - currently displayed page's source
  final List<Category> sourceCategories; // Master list - never changes unless reload
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  const CategoryLoaded({
    required this.categories,
    required this.allCategories,
    required this.sourceCategories,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
  });

  @override
  List<Object> get props => [
        categories,
        allCategories,
        sourceCategories,
        currentPage,
        totalItems,
        itemsPerPage,
      ];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryOperationSuccess extends CategoryState {
  final String message;

  const CategoryOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}
