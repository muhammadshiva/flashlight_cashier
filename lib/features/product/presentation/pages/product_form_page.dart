import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class ProductFormPage extends StatelessWidget {
  final Product? product;
  const ProductFormPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: ProductFormView(product: product),
    );
  }
}

class ProductFormView extends StatefulWidget {
  final Product? product;
  const ProductFormView({super.key, this.product});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
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
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for contrast
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit Product' : 'New Product',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
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
                        _buildLabel('Product Name'),
                        TextFormField(
                          controller: _nameController,
                          decoration:
                              _buildInputDecoration(hint: 'e.g. Cappuccino'),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Price'),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Stock'),
                                  TextFormField(
                                    controller: _stockController,
                                    decoration:
                                        _buildInputDecoration(hint: '0'),
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
                        DropdownButtonFormField<String>(
                          value: _type,
                          decoration: _buildInputDecoration(),
                          items: const [
                            DropdownMenuItem(
                                value: 'coffee', child: Text('Coffee')),
                            DropdownMenuItem(value: 'tea', child: Text('Tea')),
                            DropdownMenuItem(
                                value: 'water', child: Text('Water')),
                            DropdownMenuItem(
                                value: 'snack', child: Text('Snack')),
                            DropdownMenuItem(
                                value: 'food', child: Text('Food')),
                          ],
                          onChanged: (v) => setState(() => _type = v!),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Available for Sale'),
                          subtitle: const Text('Toggle availability status'),
                          value: _isAvailable,
                          onChanged: (val) =>
                              setState(() => _isAvailable = val),
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSubmit,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isEditMode ? 'Update Product' : 'Save Product',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({String? hint, String? prefixText}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefixText,
      filled: true,
      fillColor: Colors.grey[50],
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
