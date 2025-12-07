import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class ProductFormPage extends StatelessWidget {
  const ProductFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: const ProductFormView(),
    );
  }
}

class ProductFormView extends StatefulWidget {
  const ProductFormView({super.key});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String _type = 'coffee';

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
      context.read<ProductBloc>().add(
            CreateProductEvent(
              Product(
                id: '',
                name: _nameController.text,
                description: _descController.text,
                price: int.tryParse(_priceController.text) ?? 0,
                imageUrl: '',
                type: _type,
                stock: int.tryParse(_stockController.text) ?? 0,
                isAvailable: true,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Product')),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: const [
                    DropdownMenuItem(value: 'coffee', child: Text('Coffee')),
                    DropdownMenuItem(value: 'tea', child: Text('Tea')),
                    DropdownMenuItem(value: 'water', child: Text('Water')),
                    DropdownMenuItem(value: 'snack', child: Text('Snack')),
                    DropdownMenuItem(value: 'food', child: Text('Food')),
                  ],
                  onChanged: (v) => setState(() => _type = v!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('Save Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
