import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class ProductFormDialog extends StatelessWidget {
  final Product? product;
  const ProductFormDialog({super.key, this.product});

  /// Show the product form dialog. Returns `true` if a product was created/updated.
  static Future<bool?> show(BuildContext context, {Product? product}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProductFormDialog(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: _ProductFormDialogContent(product: product),
    );
  }
}

class _ProductFormDialogContent extends StatefulWidget {
  final Product? product;
  const _ProductFormDialogContent({this.product});

  @override
  State<_ProductFormDialogContent> createState() =>
      _ProductFormDialogContentState();
}

class _ProductFormDialogContentState extends State<_ProductFormDialogContent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late String _type;
  late bool _isAvailable;

  bool get isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    _stockController =
        TextEditingController(text: widget.product?.stock.toString() ?? '');
    _type = widget.product?.type ?? 'coffee';
    _isAvailable = widget.product?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: isEditMode ? widget.product!.id : '',
        name: _nameController.text,
        description: _descController.text,
        price: int.tryParse(_priceController.text) ?? 0,
        imageUrl: isEditMode ? widget.product!.imageUrl : '',
        type: _type,
        stock: int.tryParse(_stockController.text) ?? 0,
        isAvailable: _isAvailable,
      );

      if (isEditMode) {
        context.read<ProductBloc>().add(UpdateProductEvent(product));
      } else {
        context.read<ProductBloc>().add(CreateProductEvent(product));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context, true);
        } else if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1100.w, maxHeight: 700.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSectionCard(
                            title: 'General Information',
                            children: [
                              _buildLabel('Product Name', isRequired: true),
                              TextFormField(
                                controller: _nameController,
                                decoration: _buildInputDecoration(
                                    hint: 'e.g. Cappuccino'),
                                validator: (v) =>
                                    v!.isEmpty ? 'Name is required' : null,
                              ),
                              const SizedBox(height: 16),
                              _buildLabel('Description'),
                              TextFormField(
                                controller: _descController,
                                decoration: _buildInputDecoration(
                                    hint: 'Product description...'),
                                maxLines: 3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _buildSectionCard(
                            title: 'Pricing & Inventory',
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Price', isRequired: true),
                                        TextFormField(
                                          controller: _priceController,
                                          decoration: _buildInputDecoration(
                                            hint: '0',
                                            prefixText: '\$ ',
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (v) =>
                                              v!.isEmpty ? 'Required' : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Stock', isRequired: true),
                                        TextFormField(
                                          controller: _stockController,
                                          decoration: _buildInputDecoration(
                                              hint: '0'),
                                          keyboardType: TextInputType.number,
                                          validator: (v) =>
                                              v!.isEmpty ? 'Required' : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildLabel('Category'),
                              _buildCategorySelector(),
                              const SizedBox(height: 16),
                              SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Available for Sale'),
                                subtitle:
                                    const Text('Toggle availability status'),
                                value: _isAvailable,
                                onChanged: (val) =>
                                    setState(() => _isAvailable = val),
                                activeThumbColor: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            isEditMode ? 'Edit Product' : 'New Product',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Color(0xFF64748B)),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: _onSubmit,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isEditMode ? 'Update Product' : 'Save Product',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  static const _categories = <String, IconData>{
    'coffee': Icons.coffee_outlined,
    'tea': Icons.emoji_food_beverage_outlined,
    'water': Icons.water_drop_outlined,
    'snack': Icons.cookie_outlined,
    'food': Icons.restaurant_outlined,
    'service': Icons.build_outlined,
  };

  String _categoryLabel(String key) =>
      key[0].toUpperCase() + key.substring(1);

  Widget _buildCategorySelector() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PopupMenuButton<String>(
          offset: const Offset(0, 50),
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          color: Colors.white,
          elevation: 8,
          onSelected: (v) => setState(() => _type = v),
          itemBuilder: (_) => _categories.entries.map((e) {
            final isSelected = e.key == _type;
            return PopupMenuItem<String>(
              value: e.key,
              child: Row(
                children: [
                  Icon(
                    e.value,
                    size: 20,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _categoryLabel(e.key),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF1E293B)
                            : const Color(0xFF475569),
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            );
          }).toList(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  _categories[_type],
                  size: 20,
                  color: const Color(0xFF64748B),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _categoryLabel(_type),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          if (isRequired)
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEF4444),
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({String? hint, String? prefixText}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefixText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
