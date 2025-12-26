import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  CategoryBloc({
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
  }) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      final result = await getCategories(NoParams());
      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (categories) {
          const itemsPerPage = 10;
          final totalItems = categories.length;
          final paginatedCategories = categories.take(itemsPerPage).toList();

          emit(CategoryLoaded(
            categories: paginatedCategories,
            allCategories: categories,
            sourceCategories: categories,
            currentPage: 1,
            totalItems: totalItems,
            itemsPerPage: itemsPerPage,
          ));
        },
      );
    });

    on<ChangePageEvent>((event, emit) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        final allCategories = currentState.allCategories;
        final itemsPerPage = currentState.itemsPerPage;

        final startIndex = (event.page - 1) * itemsPerPage;
        if (startIndex >= allCategories.length) return;

        final endIndex = (startIndex + itemsPerPage) > allCategories.length
            ? allCategories.length
            : startIndex + itemsPerPage;

        final paginatedCategories = allCategories.sublist(startIndex, endIndex);

        emit(CategoryLoaded(
          categories: paginatedCategories,
          allCategories: allCategories,
          sourceCategories: currentState.sourceCategories,
          currentPage: event.page,
          totalItems: allCategories.length,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<SearchCategoriesEvent>((event, emit) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        final source = currentState.sourceCategories;

        final query = event.query.toLowerCase();
        final filtered = query.isEmpty
            ? source
            : source
                .where((c) =>
                    c.name.toLowerCase().contains(query) ||
                    c.description.toLowerCase().contains(query))
                .toList();

        const itemsPerPage = 10;
        final totalItems = filtered.length;
        final paginatedCategories = filtered.take(itemsPerPage).toList();

        emit(CategoryLoaded(
          categories: paginatedCategories,
          allCategories: filtered,
          sourceCategories: source,
          currentPage: 1,
          totalItems: totalItems,
          itemsPerPage: itemsPerPage,
        ));
      }
    });

    on<CreateCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      final result = await createCategory(event.category);
      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (_) {
          emit(const CategoryOperationSuccess("Category created"));
          add(LoadCategories());
        },
      );
    });

    on<UpdateCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      final result = await updateCategory(event.category);
      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (_) {
          emit(const CategoryOperationSuccess("Category updated"));
          add(LoadCategories());
        },
      );
    });

    on<DeleteCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      final result = await deleteCategory(event.id);
      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (_) {
          emit(const CategoryOperationSuccess("Category deleted"));
          add(LoadCategories());
        },
      );
    });
  }
}
