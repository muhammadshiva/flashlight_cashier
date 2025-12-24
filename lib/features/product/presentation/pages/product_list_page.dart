import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/product_bloc.dart';
import '../../domain/entities/product.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProducts()),
      child: const _ProductContentView(),
    );
  }
}

class _ProductContentView extends StatelessWidget {
  const _ProductContentView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderSection(),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const _StatsAndFilterSection(),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Expanded(
                    child: BlocConsumer<ProductBloc, ProductState>(
                      listener: (context, state) {
                        if (state is ProductError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is ProductLoaded) {
                          if (state.products.isEmpty) {
                            return const Center(
                              child: Text(
                                'Product not found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return _ProductTable(products: state.products);
                        }
                        return const Center(child: Text('No products found'));
                      },
                    ),
                  ),
                  const _PaginationSection(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Product Variants',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => context.push('/products/new'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangePrimary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildTab('Active', isActive: true),
            const SizedBox(width: 24),
            _buildTab('All', isActive: false),
            const SizedBox(width: 24),
            _buildTab('Draft', isActive: false),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String label, {required bool isActive}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.orangePrimary : AppColors.blackText100,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: 24,
          color: isActive ? AppColors.orangePrimary : Colors.transparent,
        ),
      ],
    );
  }
}

class _StatsAndFilterSection extends StatelessWidget {
  const _StatsAndFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        int totalItems = 0;
        if (state is ProductLoaded) {
          totalItems = state.totalItems;
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Text(
                '$totalItems Products',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Container(
                width: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          context
                              .read<ProductBloc>()
                              .add(SearchProductsEvent(value));
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search product name, sku...',
                          border: InputBorder.none,
                          isDense: true,
                          hintStyle:
                              TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, size: 18),
                label: const Text('Filter'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF64748B),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductTable extends StatelessWidget {
  final List<Product> products;

  const _ProductTable({required this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(60), // Checkbox
          1: FlexColumnWidth(3), // Product Name
          2: FlexColumnWidth(1), // SKU
          3: FlexColumnWidth(1), // Price
          4: FlexColumnWidth(1), // Stock
          5: FlexColumnWidth(1), // Status
          6: FixedColumnWidth(100), // Actions
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildHeaderRow(),
          ...products.map((product) => _buildProductRow(context, product)),
        ],
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        _HeaderCell(child: Checkbox(value: false, onChanged: (_) {})),
        const _HeaderCell(text: 'PRODUCT NAME'),
        const _HeaderCell(text: 'SKU'),
        const _HeaderCell(text: 'PRICE'),
        const _HeaderCell(text: 'STOCK'),
        const _HeaderCell(text: 'STATUS'),
        const _HeaderCell(text: ''),
      ],
    );
  }

  TableRow _buildProductRow(BuildContext context, Product product) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        TableCell(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Checkbox(
              value: false,
              onChanged: (_) {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                    image: product.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.imageUrl.isEmpty
                      ? const Icon(Icons.image_not_supported,
                          color: Color(0xFF94A3B8), size: 20)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.type, // Using type as variant/category
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _DataCell(
            text: product.id.length >= 8
                ? product.id.substring(0, 8).toUpperCase()
                : product.id.toUpperCase()), // Fake SKU
        _DataCell(text: '\$${product.price}'),
        _DataCell(text: product.stock.toString()),
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: product.isAvailable
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              product.isAvailable ? 'Active' : 'Inactive',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: product.isAvailable
                    ? const Color(0xFF166534)
                    : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 20, color: Color(0xFF64748B)),
                onPressed: () => context.push('/products/${product.id}/edit',
                    extra: product),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    size: 20, color: Color(0xFFEF4444)),
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(DeleteProductEvent(product.id));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String? text;
  final Widget? child;

  const _HeaderCell({this.text, this.child});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
        child: child ??
            Text(
              text ?? '',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8),
                letterSpacing: 1.0,
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
        ),
      ),
    );
  }
}

class _PaginationSection extends StatelessWidget {
  const _PaginationSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is! ProductLoaded) return const SizedBox.shrink();

        final currentPage = state.currentPage;
        final itemsPerPage = state.itemsPerPage;
        final totalItems = state.totalItems;
        final totalPages = (totalItems / itemsPerPage).ceil();

        final startItem = (currentPage - 1) * itemsPerPage + 1;
        final endItem = (startItem + state.products.length - 1);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('View',
                      style: TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Text('$itemsPerPage',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('entry per page',
                      style: TextStyle(color: Color(0xFF64748B))),
                ],
              ),
              Row(
                children: [
                  Text('Showing $startItem-$endItem of $totalItems entries',
                      style: const TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(width: 24),
                  IconButton(
                      onPressed: currentPage > 1
                          ? () => context
                              .read<ProductBloc>()
                              .add(ChangePageEvent(currentPage - 1))
                          : null,
                      icon: Icon(Icons.chevron_left,
                          color: currentPage > 1
                              ? const Color(0xFF64748B)
                              : const Color(0xFFCBD5E1))),
                  ...List.generate(totalPages, (index) {
                    final page = index + 1;
                    // Simple logic: show all pages for now, can be improved for large number of pages
                    if (totalPages > 7 &&
                        (page > 2 &&
                            page < totalPages - 1 &&
                            (page < currentPage - 1 ||
                                page > currentPage + 1))) {
                      return page == currentPage - 2 || page == currentPage + 2
                          ? const Text('...',
                              style: TextStyle(color: Color(0xFF64748B)))
                          : const SizedBox.shrink();
                    }
                    return _buildPageNumber(context, page,
                        isActive: page == currentPage);
                  }),
                  IconButton(
                      onPressed: currentPage < totalPages
                          ? () => context
                              .read<ProductBloc>()
                              .add(ChangePageEvent(currentPage + 1))
                          : null,
                      icon: Icon(Icons.chevron_right,
                          color: currentPage < totalPages
                              ? const Color(0xFF64748B)
                              : const Color(0xFFCBD5E1))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageNumber(BuildContext context, int number,
      {required bool isActive}) {
    return InkWell(
      onTap: () => context.read<ProductBloc>().add(ChangePageEvent(number)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.orangePrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
