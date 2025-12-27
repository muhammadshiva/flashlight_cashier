import 'package:flashlight_pos/config/routes/app_routes.dart';
import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/models/pagination_actions.dart';
import '../../../../core/shared/models/pagination_config.dart';
import '../../../../core/shared/models/pagination_data.dart';
import '../../../../core/shared/models/pagination_theme.dart';
import '../../../../core/widgets/pagination/pagination_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/category.dart';
import '../bloc/category_bloc.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryBloc>()..add(LoadCategories()),
      child: const _CategoryContentView(),
    );
  }
}

class _CategoryContentView extends StatelessWidget {
  const _CategoryContentView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderSection(),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Expanded(
                    child: BlocConsumer<CategoryBloc, CategoryState>(
                      listener: (context, state) {
                        if (state is CategoryError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is CategoryOperationSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CategoryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is CategoryLoaded) {
                          if (state.categories.isEmpty) {
                            return const Center(
                              child: Text(
                                'Category not found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return _CategoryTable(categories: state.categories);
                        }
                        return const Center(child: Text('No categories found'));
                      },
                    ),
                  ),
                  _buildPaginationSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Row(
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const Spacer(),
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        context.read<CategoryBloc>().add(SearchCategoriesEvent(value));
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search category name...',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.categoryNew),
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Add Category'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryTable extends StatelessWidget {
  final List<Category> categories;

  const _CategoryTable({required this.categories});

  @override
  Widget build(BuildContext context) {
    // Prevent rendering if empty (should not happen due to parent check, but just in case)
    if (categories.isEmpty) {
      return const Center(
        child: Text(
          'No categories found',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2), // Category Name
          1: FlexColumnWidth(3), // Description
          2: FlexColumnWidth(1), // Status
          3: FixedColumnWidth(100), // Actions
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          const TableRow(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            children: [
              _HeaderCell('CATEGORY NAME'),
              _HeaderCell('DESCRIPTION'),
              _HeaderCell('STATUS'),
              _HeaderCell('ACTION', align: Alignment.centerRight),
            ],
          ),
          ...categories.map((category) => _buildCategoryRow(context, category)),
        ],
      ),
    );
  }

  TableRow _buildCategoryRow(BuildContext context, Category category) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.orangePrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.category,
                    color: AppColors.orangePrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        _DataCell(text: category.description),
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: category.isActive ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              category.isActive ? 'Active' : 'Inactive',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: category.isActive ? const Color(0xFF166534) : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF64748B)),
                onPressed: () => context.push(AppRoutes.categoryEdit(category.id), extra: category),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFFEF4444)),
                onPressed: () {
                  _showDeleteDialog(context, category);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CategoryBloc>().add(DeleteCategoryEvent(category.id));
              Navigator.of(dialogContext).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final Alignment align;

  const _HeaderCell(this.label, {this.align = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: align,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;

  const _DataCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF475569),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

Widget _buildPaginationSection(BuildContext context) {
  return BlocBuilder<CategoryBloc, CategoryState>(
    builder: (context, state) {
      if (state is! CategoryLoaded) return const SizedBox.shrink();

      final currentPage = state.currentPage;
      final itemsPerPage = state.itemsPerPage;
      final totalItems = state.totalItems;

      // Don't show pagination if no items
      if (totalItems == 0) return const SizedBox.shrink();

      final totalPages = (totalItems / itemsPerPage).ceil();

      final startItem = (currentPage - 1) * itemsPerPage + 1;
      final endItem = (startItem + state.categories.length - 1);

      return DataDrivenPagination(
        config: PaginationConfig(
          data: PaginationData(
            currentPage: currentPage,
            totalPages: totalPages,
            itemsPerPage: itemsPerPage,
            totalItems: totalItems,
            startIndex: startItem,
            endIndex: endItem,
            isLoading: false,
            itemLabel: 'kategori',
          ),
          actions: PaginationActions(
            onPageChanged: (page) => context.read<CategoryBloc>().add(ChangePageEvent(page)),
            onItemsPerPageChanged: (count) {
              context.read<CategoryBloc>().add(ChangeItemsPerPageEvent(count));
            },
            onNextPage: currentPage < totalPages
                ? () => context.read<CategoryBloc>().add(ChangePageEvent(currentPage + 1))
                : null,
            onPreviousPage: currentPage > 1
                ? () => context.read<CategoryBloc>().add(ChangePageEvent(currentPage - 1))
                : null,
          ),
          theme: const PaginationTheme(
            primaryColor: AppColors.orangePrimary,
            backgroundColor: AppColors.white,
            textColor: AppColors.textGray3,
            disabledColor: AppColors.grey5,
            borderColor: AppColors.grey5,
          ),
        ),
      );
    },
  );
}
