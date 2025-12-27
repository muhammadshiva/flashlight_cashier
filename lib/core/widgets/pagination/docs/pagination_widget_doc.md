# Data-Driven Development (D-DD) Guide untuk Reusable Pagination

## 📋 Table of Contents
1. [Konsep D-DD](#-konsep-ddd)
2. [Prinsip D-DD](#-prinsip-ddd)
3. [Implementasi Pagination dengan D-DD](#-implementasi-pagination-dengan-ddd)
4. [Code Examples](#-code-examples)
5. [Best Practices](#-best-practices)
6. [Comparison dengan Approach Lain](#-comparison-dengan-approach-lain)
7. [Migration Guide](#-migration-guide)

---

## 🎯 Konsep D-DD

**Data-Driven Development (D-DD)** adalah paradigma pemrograman dimana **data menjadi sumber kebenaran tunggal** (single source of truth) yang mengontrol behavior dan state dari UI component.

### Core Idea:
- **Data determines UI behavior**
- **Immutable data flow**
- **Pure functions for transformations**
- **Zero component internal state**

### Traditional vs D-DD:
```
Traditional: Component → Controller → State → UI
D-DD:        Data → Component → UI
```

---

## 📊 Prinsip D-DD

### 1. **Data as Configuration**
Component menerima semua informasi yang dibutuhkan melalui data objects, bukan melalui dependency injection.

```dart
// ❌ Traditional: Component depends on controller
class InvoicePagination extends GetView<InvoicesController> {
  // Hardcoded dependency
}

// ✅ D-DD: Component depends on data
class DataDrivenPagination extends StatelessWidget {
  final PaginationConfig config; // Data determines everything
}
```

### 2. **Immutable Data Flow**
Data tidak pernah berubah setelah dibuat. Perubahan state dilakukan dengan membuat data baru.

```dart
// ✅ Immutable data
class PaginationData {
  final int currentPage;
  final int totalPages;
  final String itemLabel;
  
  const PaginationData({
    required this.currentPage,
    required this.totalPages,
    required this.itemLabel,
  });
}
```

### 3. **Pure Functions**
Functions selalu menghasilkan output yang sama untuk input yang sama, tanpa side effects.

```dart
// ✅ Pure function
List<int> calculateVisiblePages(int current, int total) {
  int startPage = (current - 2).clamp(1, total);
  int endPage = (current + 2).clamp(1, total);
  return List.generate(endPage - startPage + 1, (i) => startPage + i);
}

// ❌ Function with side effects
void updateVisiblePages() {
  visiblePages = calculatePages(currentPage, totalPages);
}
```

---

## 🏗️ Implementasi Pagination dengan D-DD

### Layer 1: Data Models

```dart
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
}
```

### Layer 2: Action Definitions

```dart
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
```

### Layer 3: Configuration

```dart
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
```

### Layer 4: Theme Configuration

```dart
/// Styling configuration untuk pagination
class PaginationTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final Color disabledColor;
  final Color borderColor;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final BoxShadow? shadow;
  
  const PaginationTheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.disabledColor,
    required this.borderColor,
    this.shimmerBaseColor = Colors.grey,
    this.shimmerHighlightColor = Colors.white,
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.all(16),
    this.textStyle,
    this.shadow,
  });
}
```

---

## 💻 Code Examples

### Pure Component Implementation

```dart
/// Data-driven pagination component
class DataDrivenPagination extends StatelessWidget {
  final PaginationConfig config;
  
  const DataDrivenPagination({
    super.key,
    required this.config,
  });
  
  @override
  Widget build(BuildContext context) {
    return config.data.isLoading 
        ? _buildLoadingState() 
        : _buildSuccessState();
  }
  
  Widget _buildSuccessState() {
    return Container(
      padding: config.theme?.padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: config.theme?.backgroundColor ?? AppColors.white,
        border: Border(top: BorderSide(
          color: config.theme?.borderColor ?? AppColors.grey5, 
          width: 1.w
        )),
        boxShadow: config.theme?.shadow != null 
            ? [config.theme!.shadow!] 
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (config.showItemsPerPageDropdown) _buildLeftSection(),
          if (config.showPageNumbers) _buildRightSection(),
        ],
      ),
    );
  }
  
  Widget _buildLeftSection() {
    return Row(
      children: [
        _buildItemsPerPageDropdown(),
        SizedBox(width: 24.w),
        if (config.showInfoCounter) _buildInfoCounter(),
      ],
    );
  }
  
  Widget _buildInfoCounter() {
    return Text(
      config.data.totalItems == 0
          ? 'Menampilkan 0 dari 0 ${config.data.itemLabel}'
          : 'Menampilkan ${config.data.startIndex}-${config.data.endIndex} dari ${config.data.totalItems} ${config.data.itemLabel}',
      style: config.theme?.textStyle ?? 
          TextStyleConst.interRegular14.copyWith(color: AppColors.textGray3),
    );
  }
  
  Widget _buildItemsPerPageDropdown() {
    return Container(
      height: 32.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: config.theme?.borderColor ?? AppColors.grey5),
        borderRadius: BorderRadius.circular(config.theme?.borderRadius ?? 4.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: config.data.itemsPerPage,
          icon: Icon(
            Icons.keyboard_arrow_down, 
            size: 16.w, 
            color: config.theme?.textStyle?.color ?? AppColors.textGray3
          ),
          style: config.theme?.textStyle ?? 
              TextStyleConst.interRegular14.copyWith(color: AppColors.textGray3),
          items: config.data.itemsPerPageOptions.map((count) {
            return DropdownMenuItem<int>(
              value: count, 
              child: Text('$count per halaman')
            );
          }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              config.actions.onItemsPerPageChanged(newValue);
            }
          },
        ),
      ),
    );
  }
  
  Widget _buildRightSection() {
    return Row(
      children: [
        IconButton(
          onPressed: config.data.currentPage > 1 
              ? config.actions.onPreviousPage 
              : null,
          icon: Icon(
            Icons.chevron_left,
            color: config.data.currentPage > 1 
                ? config.theme?.primaryColor ?? AppColors.textGray3 
                : config.theme?.disabledColor ?? AppColors.grey5,
          ),
        ),
        ..._buildPageNumbers(),
        IconButton(
          onPressed: config.data.currentPage < config.data.totalPages 
              ? config.actions.onNextPage 
              : null,
          icon: Icon(
            Icons.chevron_right,
            color: config.data.currentPage < config.data.totalPages 
                ? config.theme?.primaryColor ?? AppColors.textGray3 
                : config.theme?.disabledColor ?? AppColors.grey5,
          ),
        ),
      ],
    );
  }
  
  List<Widget> _buildPageNumbers() {
    final pages = <Widget>[];
    final currentPage = config.data.currentPage;
    final totalPages = config.data.totalPages;

    // Calculate visible range
    int startPage = (currentPage - 2).clamp(1, totalPages);
    int endPage = (currentPage + 2).clamp(1, totalPages);

    // Add first page and ellipsis if needed
    if (startPage > 1) {
      pages.add(_buildPageNumber(1));
      if (startPage > 2) {
        pages.add(_buildPageDots());
      }
    }

    // Add visible pages
    for (int i = startPage; i <= endPage; i++) {
      pages.add(_buildPageNumber(i));
    }

    // Add last page and ellipsis if needed
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pages.add(_buildPageDots());
      }
      pages.add(_buildPageNumber(totalPages));
    }

    return pages;
  }
  
  Widget _buildPageNumber(int page) {
    final isCurrentPage = page == config.data.currentPage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: InkWell(
        onTap: () => config.actions.onPageChanged(page),
        child: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isCurrentPage 
                ? config.theme?.primaryColor ?? AppColors.blackText900 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(config.theme?.borderRadius ?? 4.r),
          ),
          child: Center(
            child: Text(
              page.toString(),
              style: config.theme?.textStyle ?? 
                  TextStyleConst.interMedium14.copyWith(
                    color: isCurrentPage 
                        ? AppColors.white 
                        : AppColors.textGray3,
                  ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildPageDots() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        '...',
        style: config.theme?.textStyle ?? 
            TextStyleConst.interMedium14.copyWith(color: AppColors.textGray3),
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: (config.theme?.shimmerBaseColor ?? AppColors.grey5).withValues(alpha: 0.5),
      highlightColor: (config.theme?.shimmerHighlightColor ?? AppColors.white).withValues(alpha: 0.7),
      child: _buildSuccessState(),
    );
  }
}
```

### Usage Examples

```dart
// Invoice Page
class InvoicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(
      builder: (controller) {
        return Column(
          children: [
            // Invoice list content
            Expanded(child: _buildInvoiceList()),
            
            // D-DD Pagination
            DataDrivenPagination(
              config: PaginationConfig(
                data: PaginationData(
                  currentPage: controller.currentPage,
                  totalPages: controller.totalPages,
                  itemsPerPage: controller.itemsPerPage,
                  totalItems: controller.totalFilteredCount,
                  startIndex: controller.startIndex,
                  endIndex: controller.endIndex,
                  isLoading: controller.invoicesData.value is UIStateLoading,
                  itemLabel: 'faktur',
                ),
                actions: PaginationActions(
                  onPageChanged: controller.goToPage,
                  onItemsPerPageChanged: controller.updateItemsPerPage,
                  onNextPage: controller.nextPage,
                  onPreviousPage: controller.previousPage,
                ),
                theme: PaginationTheme(
                  primaryColor: AppColors.blackText900,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.textGray3,
                  disabledColor: AppColors.grey5,
                  borderColor: AppColors.grey5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Customer Page dengan tema berbeda
class CustomersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomersController>(
      builder: (controller) {
        return DataDrivenPagination(
          config: PaginationConfig(
            data: PaginationData(
              currentPage: controller.currentPage,
              totalPages: controller.totalPages,
              itemsPerPage: controller.itemsPerPage,
              totalItems: controller.totalFilteredCount,
              startIndex: controller.startIndex,
              endIndex: controller.endIndex,
              isLoading: controller.customersData.value is UIStateLoading,
              itemLabel: 'pelanggan',
            ),
            actions: PaginationActions(
              onPageChanged: controller.goToPage,
              onItemsPerPageChanged: controller.updateItemsPerPage,
            ),
            theme: PaginationTheme(
              primaryColor: AppColors.blueOriginal500, // Tema berbeda
              backgroundColor: AppColors.greyBackground,
              textColor: AppColors.textGray3,
              disabledColor: AppColors.grey5,
              borderColor: AppColors.grey5,
            ),
            showItemsPerPageDropdown: false, // Konfigurasi berbeda
          ),
        );
      },
    );
  }
}
```

---

## 🎯 Best Practices

### 1. **Immutable Data**
```dart
// ✅ Good: Immutable dengan final fields
class PaginationData {
  final int currentPage;
  final int totalPages;
  
  const PaginationData({required this.currentPage, required this.totalPages});
  
  // Helper untuk create copy dengan perubahan
  PaginationData copyWith({int? currentPage}) {
    return PaginationData(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages,
    );
  }
}

// ❌ Bad: Mutable data
class PaginationData {
  int currentPage; // Bisa diubah kapan saja
  int totalPages;
  
  PaginationData({required this.currentPage, required this.totalPages});
}
```

### 2. **Pure Functions**
```dart
// ✅ Good: Pure function
List<int> calculateVisiblePages(int current, int total) {
  int startPage = (current - 2).clamp(1, total);
  int endPage = (current + 2).clamp(1, total);
  return List.generate(endPage - startPage + 1, (i) => startPage + i);
}

// ❌ Bad: Function dengan side effects
void updateVisiblePages() {
  startPage = (currentPage - 2).clamp(1, totalPages);
  endPage = (currentPage + 2).clamp(1, totalPages);
  visiblePages = List.generate(endPage - startPage + 1, (i) => startPage + i);
}
```

### 3. **Single Responsibility**
```dart
// ✅ Good: Terpisah dengan jelas
class PaginationData { /* hanya data */ }
class PaginationActions { /* hanya aksi */ }
class PaginationTheme { /* hanya styling */ }
class PaginationConfig { /* hanya konfigurasi */ }

// ❌ Bad: Mixed responsibilities
class PaginationConfig {
  int currentPage;     // data
  void nextPage();     // aksi
  Color primaryColor;  // styling
}
```

### 4. **Defensive Programming**
```dart
// ✅ Good: Input validation
Widget _buildPageNumber(int page) {
  final isCurrentPage = page == config.data.currentPage;
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: InkWell(
      onTap: () {
        // Validasi sebelum execute action
        if (page >= 1 && page <= config.data.totalPages) {
          config.actions.onPageChanged(page);
        }
      },
      child: Container(/* ... */),
    ),
  );
}

// ❌ Bad: No validation
Widget _buildPageNumber(int page) {
  return InkWell(
    onTap: () => config.actions.onPageChanged(page), // Bisa menyebabkan error
    child: Container(/* ... */),
  );
}
```

---

## 📊 Comparison dengan Approach Lain

| Aspect | Traditional | Interface-Based | D-DD (Data-Driven) |
|--------|-------------|------------------|---------------------|
| **Complexity** | Low | Medium | Low |
| **Flexibility** | Low | High | Very High |
| **Testability** | Poor | Good | Excellent |
| **Migration Effort** | N/A | High | Low |
| **Learning Curve** | Low | Medium | Low |
| **Reusability** | Poor | Good | Excellent |
| **Maintainability** | Poor | Good | Excellent |
| **Performance** | Good | Good | Excellent |

### When to Use Each Approach:

#### **Traditional Approach**
- ✅ Simple, one-off components
- ✅ Prototype/MVP development
- ✅ Tight coupling acceptable

#### **Interface-Based Approach**
- ✅ Multiple similar components
- ✅ Need for type safety
- ✅ Complex inheritance hierarchies

#### **D-DD Approach**
- ✅ Highly reusable components
- ✅ Maximum flexibility needed
- ✅ Complex customization requirements
- ✅ Easy testing required

---

## 🔄 Migration Guide

### From Traditional to D-DD

#### Step 1: Identify Data
```dart
// Traditional: Data scattered in controller
class InvoicesController {
  int get currentPage => _currentPage.value;
  int get totalPages => _totalPages.value;
  String get itemLabel => 'faktur';
}

// D-DD: Centralized data
final paginationData = PaginationData(
  currentPage: controller.currentPage,
  totalPages: controller.totalPages,
  itemLabel: 'faktur',
  // ... other data
);
```

#### Step 2: Extract Actions
```dart
// Traditional: Methods in controller
class InvoicesController {
  void nextPage() { /* ... */ }
  void goToPage(int page) { /* ... */ }
}

// D-DD: Action callbacks
final actions = PaginationActions(
  onNextPage: controller.nextPage,
  onPageChanged: controller.goToPage,
);
```

#### Step 3: Create Configuration
```dart
final config = PaginationConfig(
  data: paginationData,
  actions: actions,
  theme: theme,
);
```

#### Step 4: Replace Component
```dart
// Before
InvoicePagination()

// After
DataDrivenPagination(config: config)
```

### Migration Checklist

- [ ] Identify all data needed by component
- [ ] Create immutable data models
- [ ] Extract all user interactions as callbacks
- [ ] Define theme/configuration options
- [ ] Create pure UI component
- [ ] Update all usage locations
- [ ] Add unit tests for new component
- [ ] Remove old component
- [ ] Update documentation

---

## 🧪 Testing D-DD Components

### Unit Testing
```dart
testWidgets('Pagination shows correct page numbers', (tester) async {
  // Arrange: Create test data
  final testData = PaginationData(
    currentPage: 3,
    totalPages: 10,
    itemsPerPage: 5,
    totalItems: 48,
    startIndex: 11,
    endIndex: 15,
    itemLabel: 'faktur',
    isLoading: false,
  );
  
  final testActions = PaginationActions(
    onPageChanged: (page) => print('Go to page: $page'),
    onItemsPerPageChanged: (count) => print('Items per page: $count'),
  );
  
  final testConfig = PaginationConfig(
    data: testData,
    actions: testActions,
  );
  
  // Act: Build widget
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DataDrivenPagination(config: testConfig),
      ),
    ),
  );
  
  // Assert: Verify UI based on data
  expect(find.text('Menampilkan 11-15 dari 48 faktur'), findsOneWidget);
  expect(find.text('1'), findsOneWidget);  // First page
  expect(find.text('...'), findsOneWidget); // Ellipsis
  expect(find.text('3'), findsOneWidget);  // Current page
  expect(find.text('10'), findsOneWidget); // Last page
});
```

### Data Testing
```dart
test('PaginationData copyWith creates correct copy', () {
  // Arrange
  final original = PaginationData(
    currentPage: 2,
    totalPages: 5,
    itemsPerPage: 10,
    totalItems: 48,
    startIndex: 11,
    endIndex: 20,
    itemLabel: 'faktur',
  );
  
  // Act
  final copy = original.copyWith(currentPage: 3);
  
  // Assert
  expect(copy.currentPage, equals(3));
  expect(copy.totalPages, equals(5)); // Unchanged
  expect(copy.itemLabel, equals('faktur')); // Unchanged
});
```

---

## 📚 Resources

### Recommended Reading
- [Data-Driven Development Principles](https://example.com/ddd-principles)
- [Immutable Data in Flutter](https://example.com/immutable-flutter)
- [Pure Functions in Dart](https://example.com/pure-functions-dart)

### Related Patterns
- **State Pattern**: Untuk mengelola berbagai state UI
- **Strategy Pattern**: Untuk algoritma pagination yang berbeda
- **Observer Pattern**: Untuk reactive updates

### Tools & Libraries
- **equatable**: Untuk value equality di data models
- **freezed**: Untuk immutable data classes
- **bloc**: Untuk state management (jika perlu)

---

## 🎉 Conclusion

Data-Driven Development (D-DD) provides a powerful approach for creating highly reusable, testable, and maintainable UI components. By treating data as the single source of truth, we can create components that are:

- **Predictable**: Same data always produces same UI
- **Testable**: Easy to unit test without complex setups
- **Reusable**: Same component works for different data types
- **Maintainable**: Clear separation of concerns
- **Flexible**: Highly configurable through data

The pagination component example demonstrates how D-DD principles can be applied to create a truly reusable component that works across different features while maintaining type safety and performance.

---

**Happy Coding with D-DD! 🚀**